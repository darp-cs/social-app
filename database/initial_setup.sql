CREATE SCHEMA IF NOT EXISTS social_app;


-- Users table to store user information

DROP TABLE IF EXISTS social_app.users;
CREATE TABLE social_app.users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO social_app.users (username, email, password_hash) VALUES
('john_doe', 'john.doe@example.com', 'password123'),
('jane_smith', 'jane.smith@example.com', 'securePass!45'),
('michael_brown', 'michael.brown@example.com', 'mikeBrown2025'),
('emily_davis', 'emily.davis@example.com', 'emilyRocks99'),
('chris_jones', 'chris.jones@example.com', 'chrisPass2025'),
('sarah_wilson', 'sarah.wilson@example.com', 'wilsonSarah!23'),
('david_miller', 'david.miller@example.com', 'davidM123'),
('laura_garcia', 'laura.garcia@example.com', 'lauraG@2025'),
('james_martinez', 'james.martinez@example.com', 'martinezJames!'),
('olivia_hernandez', 'olivia.hernandez@example.com', 'oliviaH2025');

-- User profiles table to store additional user information
DROP TABLE IF EXISTS social_app.user_profiles;
CREATE TABLE social_app.user_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    bio TEXT,
    profile_picture BLOB,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
INSERT INTO social_app.user_profiles (user_id, bio, profile_picture) VALUES 
(1, 'Tech enthusiast and avid gamer.', NULL),
(2, 'Loves hiking and outdoor adventures.', NULL),
(3, 'Photographer and coffee lover.', NULL),
(4, 'Aspiring writer and bookworm.', NULL),
(5, 'Fitness trainer and nutrition expert.', NULL),
(6, 'Musician and music producer.', NULL),
(7, 'Travel blogger exploring the world.', NULL),
(8, 'Software developer passionate about AI.', NULL),
(9, 'Foodie and amateur chef.', NULL),
(10, 'Entrepreneur and startup founder.', NULL);



-- Need to add a friend request table to manage friend requests and messages associated with them
DROP TABLE IF EXISTS social_app.friend_requests;   
-- Friends table to manage friend relationships
DROP TABLE IF EXISTS social_app.friends;
CREATE TABLE social_app.friends (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES users(id) ON DELETE CASCADE
);
INSERT INTO social_app.friends (user_id, friend_id) VALUES
(1, 2), -- john_doe is friends with jane_smith
(1, 3), -- john_doe is friends with michael_brown
(2, 4), -- jane_smith is friends with emily_davis
(3, 5), -- michael_brown is friends with chris_jones
(4, 6), -- emily_davis is friends with sarah_wilson
(5, 7), -- chris_jones is friends with david_miller
(6, 8), -- sarah_wilson is friends with laura_garcia
(7, 9), -- david_miller is friends with james_martinez
(8, 10), -- laura_garcia is friends with olivia_hernandez
(9, 1); -- james_martinez is friends with john_doe


-- Messages table to store messages between users
DROP TABLE IF EXISTS social_app.messages;
CREATE TABLE social_app.messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);
