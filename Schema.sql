CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT now()
);
CREATE TABLE events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  date DATE NOT NULL,
  city TEXT,
  created_by UUID REFERENCES users(id) ON DELETE CASCADE
);
CREATE TABLE rsvps (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  event_id UUID REFERENCES events(id) ON DELETE CASCADE,
  status TEXT CHECK (status IN ('Yes', 'No', 'Maybe')),
  UNIQUE(user_id, event_id) -- prevent duplicate RSVPs
);
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
INSERT INTO rsvps (user_id, event_id, status)
SELECT u.id, e.id, 
       (ARRAY['Yes', 'No', 'Maybe'])[floor(random() * 3 + 1)::int]
FROM users u
JOIN events e ON random() < 0.4
LIMIT 20;

