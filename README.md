**Event RSVP Platform – Supabase Database Design**
A scalable, relational database schema for an event management system where users can register, create events, and RSVP to events with a response of Yes, No, or Maybe.
Built using PostgreSQL on Supabase, this project demonstrates good relational design, data integrity enforcement, and randomized sample data generation.
**1. Users**
    Stores information about registered users.
   id       ->   UUID (Primary Key, auto-generated)
   name     ->   TEXT (Required)
   email    ->   TEXT (Unique, Required)
   created_at -> TIMESTAMP (Default: current time)
**2. Events**
    Stores event details.
    id          ->  UUID (Primary Key, auto-generated)
    title       ->  TEXT (Required)
    description ->  TEXT
    date        ->  DATE (Required)
    city        ->  TEXT
    created_by  ->  UUID (References users.id, Cascade on delete)
**3. RSVPs**
    Stores user responses to events.  
    id         ->     UUID (Primary Key, auto-generated)
    user_id    ->     UUID (References users.id, Cascade on delete)
    event_id   ->     UUID (References events.id, Cascade on delete)
    status     ->     TEXT (Allowed: 'Yes', 'No', 'Maybe')
    UNIQUE(user_id, event_id)-> Prevents the Duplicates
**Sample Data**  
   Insert Users and events  data into the tables.
     INSERT INTO users (name, email)
 VALUES 
  ('Reddy Ranjith', 'ranjith123@gmail.com'),
  ('Bob Smith', 'bob098@gmail.com.com'),
  ('Kiran A', 'kiran2938@gmail.com'),
  ('B Master', 'maskja@gmail.com'),
  ('Ethan Green', 'ethan@gmail.com'),
  ('vijay annandhi', 'vijay@gmail.com'),
  ('George White', 'george@example.com'),
  ('Mark king', 'king@gmail.com'),
  ('Isaac Black', 'isaac@example.com'),
  ('Julia Pink', 'julia@example.com');
  INSERT INTO events (title, description, date, city, created_by)
VALUES 
  ('Tech Conference', 'Annual tech meetup', '2025-09-15', 'New York', (SELECT id FROM users LIMIT 1 OFFSET 0)),
  ('Startup Pitch', 'Pitch your startup idea', '2025-09-20', 'San Francisco', (SELECT id FROM users LIMIT 1 OFFSET 1)),
  ('Music Fest', 'Enjoy live music performances', '2025-10-05', 'Austin', (SELECT id FROM users LIMIT 1 OFFSET 2)),
  ('AI Workshop', 'Hands-on AI session', '2025-08-25', 'Boston', (SELECT id FROM users LIMIT 1 OFFSET 3)),
  ('Design Meetup', 'Networking for designers', '2025-09-10', 'Chicago', (SELECT id FROM users LIMIT 1 OFFSET 4));
  **How to Use** 
1. Go to your Supabase SQL editor.
2. Write you Script for event management system.
3. Run the script.
4. Check your **Tables** and **ER Diagram** under "Table Editor"
