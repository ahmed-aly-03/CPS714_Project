const express = require('express');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');

const app = express();
app.use(cors());
app.use(express.json());


const supabaseUrl = 'https://ydvtqvyugkbmbotmcnfx.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlkdnRxdnl1Z2tibWJvdG1jbmZ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM1MDEzNTgsImV4cCI6MjA3OTA3NzM1OH0.djVX68n96IogFbYZNQ_FZ67W6hP-m7piFHfcAQoQy0U'; 
const port = 3000;

const supabase = createClient(supabaseUrl, supabaseKey);

async function getRsvpData(eventId) {
  const { data, error } = await supabase
    .from('rsvps')
    .select('*')
    .eq('event_id', eventId);

  if (error) throw error;
  return data;
}

async function getActualAttendance(eventId) {
  const { data, error } = await supabase
    .from('attendance')
    .select('student_id')
    .eq('event_id', eventId);

  if (error) throw error;

  const uniqueStudentIds = new Set(data.map(row => row.student_id));
  return uniqueStudentIds.size;
}

async function getRsvpGoingCount(eventId) {
  const { data, error } = await supabase
    .from('rsvps')
    .select('student_id')
    .eq('event_id', eventId)
    .eq('rsvp_status', 'Going');

  if (error) throw error;
  return data.length;
}

async function getAttendanceRate(eventId) {
  const [actual, going] = await Promise.all([
    getActualAttendance(eventId),
    getRsvpGoingCount(eventId),
  ]);

  if (going === 0) return 0;
  return actual / going;
}

async function getAverageStarRating(eventId) {
  const { data, error } = await supabase
    .from('feedback')
    .select('rating')
    .eq('event_id', eventId);

  if (error) throw error;
  if (!data || data.length === 0) return null;

  const sum = data.reduce((acc, row) => acc + row.rating, 0);
  return sum / data.length;
}

async function getComments(eventId) {
  const { data, error } = await supabase
    .from('feedback')
    .select('student_id, comment_text, rating, would_recommend')
    .eq('event_id', eventId);

  if (error) throw error;

  return data.filter(
    row => row.comment_text && row.comment_text.trim() !== ''
  );
}

async function getDepartmentsAndMajors(eventId) {
  const { data, error } = await supabase
    .from('attendance')
    .select(`
      student_id,
      students (
        department,
        major
      )
    `)
    .eq('event_id', eventId);

  if (error) throw error;

  const departments = {};
  const majors = {};

  for (const row of data) {
    const student = row.students;
    if (!student) continue;

    if (student.department) {
      departments[student.department] =
        (departments[student.department] || 0) + 1;
    }

    if (student.major) {
      majors[student.major] =
        (majors[student.major] || 0) + 1;
    }
  }

  return { departments, majors };
}

app.get('/api/events/:id/summary', async (req, res) => {
  const eventId = parseInt(req.params.id, 10);

  try {
    const [
      rsvpData,
      actualAttendance,
      attendanceRate,
      avgRating,
      comments,
      deptMajors,
    ] = await Promise.all([
      getRsvpData(eventId),
      getActualAttendance(eventId),
      getAttendanceRate(eventId),
      getAverageStarRating(eventId),
      getComments(eventId),
      getDepartmentsAndMajors(eventId),
    ]);

    res.json({
      eventId,
      rsvpCount: rsvpData.length,
      rsvps: rsvpData,
      actualAttendance,
      attendanceRate,
      averageRating: avgRating,
      comments,
      departments: deptMajors.departments,
      majors: deptMajors.majors,
    });
  } catch (err) {
    console.error('Error in /api/events/:id/summary:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(port, () => {
  console.log(`Backend server running on http://localhost:${port}`);
});
