CPS714 – Organizer Analytics & Reporting Backend
==================================================

This project is a small Node.js/Express backend that connects to a Supabase Postgres database and exposes an API for the Organizer Analytics & Reporting Dashboard (Task 7).

It provides data for:
- RSVP Data
- Actual Attendance
- Attendance Rate
- Average Star Ratings
- Comments
- Departments and Majors of students who attended

--------------------------------------------------
Project Contents
--------------------------------------------------

This repo includes:
- dashboard.js – backend server code (Node.js + Express + Supabase)
- package.json – project dependencies and scripts
- package-lock.json – exact dependency versions
- table_creation_script.sql – SQL script to create all tables
- table_inserts.sql – SQL script to insert dummy data

--------------------------------------------------
1. Prerequisites
--------------------------------------------------

1) Node.js (LTS) installed
   - Download and install from the official Node.js website (LTS version).
   - Verify in a terminal:

       node -v
       npm -v

     Both commands should print a version number.

2) A Supabase account and project
   - Free tier is sufficient.

--------------------------------------------------
2. Clone this Repository
--------------------------------------------------

In a terminal:

   git clone https://github.com/<your-username>/<your-repo-name>.git
   cd <your-repo-name>

Replace <your-username> and <your-repo-name> with the actual values.

You should now see files like:

   ls
   # dashboard.js  package.json  package-lock.json  table_creation_script.sql  table_inserts.sql  ...

--------------------------------------------------
3. Install Dependencies
--------------------------------------------------

From the project folder (where package.json is located), run:

   npm install

This installs express, cors, and @supabase/supabase-js using package.json / package-lock.json.

--------------------------------------------------
4. Run the Backend Server
--------------------------------------------------

In the same folder:

   node dashboard.js

If everything is configured correctly, you should see:

   Backend server running on http://localhost:3000

--------------------------------------------------
5. Test the API
--------------------------------------------------

Open a browser or API client (Postman, Thunder Client, etc.) and request:

   http://localhost:3000/api/events/1/summary

You should receive JSON similar to:

   {
     "eventId": 1,
     "rsvpCount": 8,
     "rsvps": [ ... ],
     "actualAttendance": 5,
     "attendanceRate": 0.83,
     "averageRating": 4.2,
     "comments": [ ... ],
     "departments": {
       "Faculty of Engineering and Architectural Science": 4,
       "Faculty of Science": 1
     },
     "majors": {
       "Computer Engineering": 2,
       "Mechanical Engineering": 1,
       "Electrical Engineering": 1,
       "Computer Science": 1
     }
   }

These fields map directly to the dashboard requirements:
- RSVP Data → rsvps and rsvpCount
- Actual Attendance → actualAttendance
- Attendance Rate → attendanceRate
- Average Star Ratings → averageRating
- Comments → comments
- Departments & Majors of attendees → departments, majors

--------------------------------------------------
6. Endpoint Summary
--------------------------------------------------

Currently, the backend exposes:

Endpoint:
   GET /api/events/:id/summary

Path parameters:
   id – Event ID (e.g. 1, 2, 3)

Response JSON:
- eventId – the event id
- rsvpCount – number of RSVPs
- rsvps – array of RSVP records
- actualAttendance – number of unique attendees
- attendanceRate – actual attendance / RSVP (Going)
- averageRating – average star rating (1–5)
- comments – feedback entries that include comment_text
- departments – object mapping department → attendee count
- majors – object mapping major → attendee count

This endpoint is intended to be consumed by the frontend Organizer Analytics & Reporting Dashboard for CPS714 Task 7.
