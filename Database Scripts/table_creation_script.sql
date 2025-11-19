do $$
begin
  if not exists (select 1 from pg_type where typname = 'rsvp_status') then
    create type rsvp_status as enum ('Going', 'Interested', 'Waitlisted', 'Cancelled');
  end if;
end$$;

do $$
begin
  if not exists (select 1 from pg_type where typname = 'check_in_method') then
    create type check_in_method as enum ('QR', 'Manual List', 'Kiosk');
  end if;
end$$;

create table if not exists public.students (
  student_id varchar(20) primary key,
  first_name text,
  last_name text,
  department text,
  major text,
  year_level integer
);

create table if not exists public.events (
  event_id bigserial primary key,
  event_title text not null,
  description text,
  event_date date not null,
  start_time time,
  end_time time,
  location text,
  capacity integer,
  category text,
  status text not null default 'Scheduled'
);

create table if not exists public.rsvps (
  rsvp_id bigserial primary key,
  event_id bigint not null references public.events(event_id) on delete cascade,
  student_id varchar(20) not null references public.students(student_id),
  rsvp_status rsvp_status not null default 'Going',
  rsvp_timestamp timestamptz not null default now(),
  waitlist_flag boolean not null default false,
  unique (event_id, student_id)
);

create table if not exists public.attendance (
  attendance_id bigserial primary key,
  event_id bigint not null references public.events(event_id) on delete cascade,
  student_id varchar(20) not null references public.students(student_id),
  check_in_time timestamptz not null default now(),
  check_in_method check_in_method default 'Manual List',
  attended_flag boolean not null default true,
  unique (event_id, student_id)
);

create table if not exists public.feedback (
  feedback_id bigserial primary key,
  event_id bigint not null references public.events(event_id) on delete cascade,
  student_id varchar(20) references public.students(student_id),
  rating integer not null check (rating between 1 and 5),
  comment_text text,
  would_recommend boolean
);

create index if not exists idx_rsvps_event_id on public.rsvps(event_id);
create index if not exists idx_attendance_event_id on public.attendance(event_id);
create index if not exists idx_feedback_event_id on public.feedback(event_id);
