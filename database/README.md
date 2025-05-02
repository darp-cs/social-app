# Social App Database Schema

This document provides an overview of the database schema defined in the `initial_setup.sql` file. The schema is designed for a social application and includes tables for managing users, their profiles, friendships, and messages.

## Database Schema: `social_app`

### 1. `users` Table
The `users` table stores basic information about the users of the application.

- **Columns**:
  - `id`: Primary key, unique identifier for each user.
  - `username`: Unique username for the user.
  - `email`: Unique email address for the user.
  - `password_hash`: Hashed password for authentication.
  - `created_at`: Timestamp indicating when the user was created.

- **Purpose**: This table is the core of the application, storing essential user information.

---

### 2. `user_profiles` Table
The `user_profiles` table stores additional information about users, such as their bio and profile picture.

- **Columns**:
  - `id`: Primary key, unique identifier for each profile.
  - `user_id`: Foreign key referencing the `id` column in the `users` table.
  - `bio`: A short biography or description of the user.
  - `profile_picture`: Binary data for storing the user's profile picture.

- **Relationships**:
  - Each profile is linked to a user in the `users` table via the `user_id` foreign key.
  - If a user is deleted, their profile is also deleted (`ON DELETE CASCADE`).

- **Purpose**: This table extends the `users` table by storing additional user details.

---

### 3. `friends` Table
The `friends` table manages friendships between users.

- **Columns**:
  - `id`: Primary key, unique identifier for each friendship.
  - `user_id`: Foreign key referencing the `id` column in the `users` table.
  - `friend_id`: Foreign key referencing the `id` column in the `users` table.
  - `created_at`: Timestamp indicating when the friendship was created.

- **Relationships**:
  - Both `user_id` and `friend_id` reference the `users` table.
  - If a user is deleted, their friendships are also deleted (`ON DELETE CASCADE`).

- **Purpose**: This table tracks friendships between users.

---

### 4. `messages` Table
The `messages` table stores messages exchanged between users.

- **Columns**:
  - `id`: Primary key, unique identifier for each message.
  - `sender_id`: Foreign key referencing the `id` column in the `users` table (the sender of the message).
  - `receiver_id`: Foreign key referencing the `id` column in the `users` table (the recipient of the message).
  - `content`: The text content of the message.
  - `sent_at`: Timestamp indicating when the message was sent.

- **Relationships**:
  - Both `sender_id` and `receiver_id` reference the `users` table.
  - If a user is deleted, their messages are also deleted (`ON DELETE CASCADE`).

- **Purpose**: This table facilitates communication between users.

---

## Relationships Overview
- The `users` table is the central table, with other tables referencing it via foreign keys.
- The `user_profiles` table extends user information.
- The `friends` table establishes relationships between users.
- The `messages` table enables communication between users.

This schema is designed to support a social application with features like user profiles, friendships, and messaging.