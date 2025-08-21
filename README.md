**Event RSVP Platform – Supabase Database Design**

A scalable, relational database schema for an event management system where users can register, create events, and RSVP to events with a response of **Yes**, **No**, or **Maybe**.

Built using PostgreSQL on **Supabase**, this project demonstrates good relational design, data integrity enforcement, and randomized sample data generation.

---

**Schema Overview**
This project defines three main tables:

 Users
| Column       | Type   | Description                  |
|--------------|--------|------------------------------|
| `id`         | UUID   | Primary key (auto-generated) |
| `name`       | Text   | User's full name             |
| `email`      | Text   | Unique email address         |
| `created_at` | Timestamp | Defaults to now()         |

---

Events
| Column       | Type   | Description                         |
|--------------|--------|-------------------------------------|
| `id`         | UUID   | Primary key                         |
| `title`      | Text   | Event title                         |
| `description`| Text   | Description of the event            |
| `date`       | Date   | Date of the event                   |
| `city`       | Text   | Event location                      |
| `created_by` | UUID   | Foreign key → `users(id)`           |

 `created_by` is a foreign key referencing the user who created the event.
`ON DELETE CASCADE` ensures events are deleted if the user is removed.

---

RSVPs
| Column     | Type   | Description                               |
|------------|--------|-------------------------------------------|
| `id`       | UUID   | Primary key                               |
| `user_id`  | UUID   | Foreign key → `users(id)`                 |
| `event_id` | UUID   | Foreign key → `events(id)`                |
| `status`   | Text   | One of `'Yes'`, `'No'`, `'Maybe'`         |

 RSVP status is constrained with a `CHECK` to allow only valid responses.
 Unique constraint on `(user_id, event_id)` prevents duplicate RSVPs.
 Cascading deletes clean up RSVPs if the associated user or event is deleted.

---

**Sample Data**

10 Users  inserted with realistic names and emails.
 5 Events created by the first five users.
20 RSVPs  inserted using a random SQL generator to simulate realistic participation across users and events.

