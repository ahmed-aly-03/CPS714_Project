insert into public.students (student_id, first_name, last_name, department, major, year_level)
values
  ('501061241', 'Ahmed',  'Aly',    'Faculty of Engineering and Architectural Science', 'Computer Engineering',   3),
  ('501061242', 'Sara',   'Nguyen', 'Faculty of Engineering and Architectural Science', 'Mechanical Engineering', 2),
  ('501061243', 'Jason',  'Patel',  'Faculty of Science',                               'Computer Science',       1),
  ('501061244', 'Emily',  'Rossi',  'Faculty of Arts',                                  'Psychology',             4),
  ('501061245', 'Mohamed','Khan',   'Faculty of Engineering and Architectural Science', 'Electrical Engineering', 3),
  ('501061246', 'Chloe',  'Smith',  'Faculty of Business',                              'Business Management',    2),
  ('501061247', 'Liam',   'Chen',   'Faculty of Science',                               'Mathematics',            1),
  ('501061248', 'Noah',   'Garcia', 'Faculty of Arts',                                  'History',                4),
  ('501061249', 'Olivia', 'Brown',  'Faculty of Engineering and Architectural Science', 'Industrial Engineering', 3),
  ('501061250', 'Ava',    'Singh',  'Faculty of Science',                               'Biology',                2);

insert into public.events
  (event_id, event_title, description, event_date, start_time, end_time, location, capacity, category, status)
values
  (1,
   'AI in Healthcare Panel',
   'Panel discussion on real-world applications of AI in healthcare.',
   '2025-10-15',
   '18:00',
   '20:00',
   'ENG-103',
   80,
   'Academic',
   'Completed'),
  (2,
   'Welcome Back Social',
   'Networking social event for returning and new students.',
   '2025-09-10',
   '16:00',
   '18:00',
   'SLC-200',
   100,
   'Social',
   'Completed'),
  (3,
   'Midterm Exam Prep Workshop',
   'Workshop covering study strategies and midterm preparation tips.',
   '2025-11-20',
   '14:00',
   '16:00',
   'ENG-201',
   60,
   'Academic',
   'Scheduled');

insert into public.rsvps
  (event_id, student_id, rsvp_status, waitlist_flag)
values
  (1, '501061241', 'Going',      false),
  (1, '501061242', 'Going',      false),
  (1, '501061243', 'Going',      false),
  (1, '501061244', 'Going',      false),
  (1, '501061245', 'Going',      false),
  (1, '501061249', 'Going',      false),
  (1, '501061246', 'Interested', false),
  (1, '501061250', 'Waitlisted', true),
  (2, '501061241', 'Going',      false),
  (2, '501061242', 'Going',      false),
  (2, '501061246', 'Going',      false),
  (2, '501061247', 'Going',      false),
  (2, '501061248', 'Going',      false),
  (2, '501061249', 'Going',      false),
  (2, '501061250', 'Cancelled',  false),
  (3, '501061241', 'Going',      false),
  (3, '501061243', 'Going',      false),
  (3, '501061245', 'Going',      false),
  (3, '501061247', 'Interested', false),
  (3, '501061250', 'Going',      false);

insert into public.attendance
  (event_id, student_id, check_in_method, attended_flag)
values
  (1, '501061241', 'QR',          true),
  (1, '501061242', 'QR',          true),
  (1, '501061243', 'Manual List', true),
  (1, '501061245', 'QR',          true),
  (1, '501061249', 'Manual List', true),
  (2, '501061241', 'Manual List', true),
  (2, '501061242', 'Manual List', true),
  (2, '501061246', 'QR',          true),
  (2, '501061247', 'QR',          true),
  (2, '501061248', 'Manual List', true),
  (2, '501061249', 'QR',          true),
  (3, '501061241', 'QR',          true),
  (3, '501061243', 'QR',          true),
  (3, '501061245', 'QR',          true);

insert into public.feedback
  (event_id, student_id, rating, comment_text, would_recommend)
values
  (1, '501061241', 5, 'Very informative session, loved the case studies.',                    true),
  (1, '501061242', 4, 'Good panel, but the Q&A could have been longer.',                     true),
  (1, '501061243', 5, 'Great insights on AI ethics and real hospital use cases.',            true),
  (1, '501061245', 3, 'Content was a bit advanced for first-year students.',                 false),
  (1, '501061249', 4, 'Well-organized and engaging speakers.',                               true),
  (2, '501061241', 4, 'Nice way to meet new people across different programs.',              true),
  (2, '501061246', 5, 'Loved the games, music, and snacks!',                                 true),
  (2, '501061247', 3, 'Crowded, but overall still fun.',                                     true),
  (2, '501061248', 4, 'Good mix of students from different years and majors.',              true),
  (2, '501061249', 5, 'Amazing networking opportunity with upper-year students and clubs.', true);
