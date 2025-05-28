CREATE SCHEMA IF NOT EXISTS social_app;
USE social_app;


-- Drop existing tables and triggers to avoid conflicts
DROP TRIGGER IF EXISTS before_insert_users;
DROP TRIGGER IF EXISTS before_insert_user_profiles;
DROP TRIGGER IF EXISTS before_insert_friends;
DROP TRIGGER IF EXISTS before_insert_messages;


DROP TABLE IF EXISTS social_app.messages;
DROP TABLE IF EXISTS social_app.friends;
DROP TABLE IF EXISTS social_app.friend_requests;  
DROP TABLE IF EXISTS social_app.user_profiles;
DROP TABLE IF EXISTS social_app.users;
-- Users table to store user information


CREATE TABLE social_app.users (
    id CHAR(36) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER before_insert_users
BEFORE INSERT ON social_app.users
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL THEN
        SET NEW.id = UUID();
    END IF;
END$$

DELIMITER ;

INSERT INTO social_app.users (id, username, email, password_hash, firstname, lastname) VALUES
('ad02e65e-2f76-11f0-b14f-a89c1698bbdd', 'john_doe', 'john.doe@example.com', 'password123', 'John', 'Doe'),
('ad03644e-2f76-11f0-b14f-a89c1698bbdd', 'jane_smith', 'jane.smith@example.com', 'securePass!45', 'Jane', 'Smith'),
('ad036868-2f76-11f0-b14f-a89c1698bbdd', 'michael_brown', 'michael.brown@example.com', 'mikeBrown2025', 'Michael', 'Brown'),
('ad0369ee-2f76-11f0-b14f-a89c1698bbdd', 'emily_davis', 'emily.davis@example.com', 'emilyRocks99', 'Emily', 'Davis'),
('ad036b06-2f76-11f0-b14f-a89c1698bbdd', 'chris_jones', 'chris.jones@example.com', 'chrisPass2025', 'Chris', 'Jones'),
('ad036c14-2f76-11f0-b14f-a89c1698bbdd', 'sarah_wilson', 'sarah.wilson@example.com', 'wilsonSarah!23', 'Sarah', 'Wilson'),
('ad036d22-2f76-11f0-b14f-a89c1698bbdd', 'david_miller', 'david.miller@example.com', 'davidM123', 'David', 'Miller'),
('ad036e1c-2f76-11f0-b14f-a89c1698bbdd', 'laura_garcia', 'laura.garcia@example.com', 'lauraG@2025', 'Laura', 'Garcia'),
('ad03704c-2f76-11f0-b14f-a89c1698bbdd', 'olivia_hernandez', 'olivia.hernandez@example.com', 'oliviaH2025', 'Olivia', 'Hernandez'),
('ad036f48-2f76-11f0-b14f-a89c1698bbdd', 'james_martinez', 'james.martinez@example.com', 'martinezJames!', 'James', 'Martinez');

-- User profiles table to store additional user information

CREATE TABLE social_app.user_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id CHAR(36) NOT NULL,
    bio TEXT,
    profile_picture BLOB,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER before_insert_user_profiles
BEFORE INSERT ON social_app.user_profiles
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL THEN
        SET NEW.id = UUID();
    END IF;
END$$

DELIMITER ;


INSERT INTO social_app.user_profiles (user_id, bio, profile_picture) VALUES
('ad02e65e-2f76-11f0-b14f-a89c1698bbdd', 'Tech enthusiast and avid gamer.', NULL),
('ad03644e-2f76-11f0-b14f-a89c1698bbdd', 'Loves hiking and outdoor adventures.', NULL),
('ad036868-2f76-11f0-b14f-a89c1698bbdd', 'Photographer and coffee lover.', NULL),
('ad0369ee-2f76-11f0-b14f-a89c1698bbdd', 'Aspiring writer and bookworm.', NULL),
('ad036b06-2f76-11f0-b14f-a89c1698bbdd', 'Fitness trainer and nutrition expert.', NULL),
('ad036c14-2f76-11f0-b14f-a89c1698bbdd', 'Musician and music producer.', NULL),
('ad036d22-2f76-11f0-b14f-a89c1698bbdd', 'Travel blogger exploring the world.', NULL),
('ad036e1c-2f76-11f0-b14f-a89c1698bbdd', 'Software developer passionate about AI.', NULL),
('ad03704c-2f76-11f0-b14f-a89c1698bbdd', 'Foodie and amateur chef.', NULL),
('ad036f48-2f76-11f0-b14f-a89c1698bbdd', 'Entrepreneur and startup founder.', NULL);



-- Need to add a friend request table to manage friend requests and messages associated with them
 
-- Friends table to manage friend relationships

CREATE TABLE social_app.friends (
    id CHAR(36) PRIMARY KEY,
    user_id CHAR(36) NOT NULL,
    friend_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES users(id) ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER before_insert_friends
BEFORE INSERT ON social_app.friends
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL THEN
        SET NEW.id = UUID();
    END IF;
END$$

DELIMITER ;


INSERT INTO social_app.friends (user_id, friend_id) VALUES
('ad02e65e-2f76-11f0-b14f-a89c1698bbdd', 'ad03644e-2f76-11f0-b14f-a89c1698bbdd'), -- john_doe is friends with jane_smith
('ad02e65e-2f76-11f0-b14f-a89c1698bbdd', 'ad036868-2f76-11f0-b14f-a89c1698bbdd'), -- john_doe is friends with michael_brown
('ad03644e-2f76-11f0-b14f-a89c1698bbdd', 'ad0369ee-2f76-11f0-b14f-a89c1698bbdd'), -- jane_smith is friends with emily_davis
('ad036868-2f76-11f0-b14f-a89c1698bbdd', 'ad036b06-2f76-11f0-b14f-a89c1698bbdd'), -- michael_brown is friends with chris_jones
('ad0369ee-2f76-11f0-b14f-a89c1698bbdd', 'ad036c14-2f76-11f0-b14f-a89c1698bbdd'), -- emily_davis is friends with sarah_wilson
('ad036b06-2f76-11f0-b14f-a89c1698bbdd', 'ad036d22-2f76-11f0-b14f-a89c1698bbdd'), -- chris_jones is friends with david_miller
('ad036c14-2f76-11f0-b14f-a89c1698bbdd', 'ad036e1c-2f76-11f0-b14f-a89c1698bbdd'), -- sarah_wilson is friends with laura_garcia
('ad036d22-2f76-11f0-b14f-a89c1698bbdd', 'ad03704c-2f76-11f0-b14f-a89c1698bbdd'), -- david_miller is friends with olivia_hernandez
('ad036e1c-2f76-11f0-b14f-a89c1698bbdd', 'ad036f48-2f76-11f0-b14f-a89c1698bbdd'), -- laura_garcia is friends with james_martinez
('ad036f48-2f76-11f0-b14f-a89c1698bbdd', 'ad02e65e-2f76-11f0-b14f-a89c1698bbdd'); -- james_martinez is friends with john_doe


-- Messages table to store messages between users



CREATE TABLE social_app.messages (
    id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36) NOT NULL,
    receiver_id CHAR(36) NOT NULL,
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER before_insert_messages
BEFORE INSERT ON social_app.messages
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL THEN
        SET NEW.id = UUID();
    END IF;
END$$

DELIMITER ;

INSERT INTO social_app.messages (id, sender_id, receiver_id, content) VALUES
(NULL, 'ad02e65e-2f76-11f0-b14f-a89c1698bbdd', 'ad03644e-2f76-11f0-b14f-a89c1698bbdd', 'Hey Jane, how are you?'), -- john_doe to jane_smith
(NULL, 'ad03644e-2f76-11f0-b14f-a89c1698bbdd', 'ad02e65e-2f76-11f0-b14f-a89c1698bbdd', 'Hi John, I am good. How about you?'), -- jane_smith to john_doe
(NULL, 'ad036868-2f76-11f0-b14f-a89c1698bbdd', 'ad036b06-2f76-11f0-b14f-a89c1698bbdd', 'Hey Chris, let’s catch up soon!'), -- michael_brown to chris_jones
(NULL, 'ad036b06-2f76-11f0-b14f-a89c1698bbdd', 'ad036868-2f76-11f0-b14f-a89c1698bbdd', 'Sure Michael, let me know when you are free.'), -- chris_jones to michael_brown
(NULL, 'ad0369ee-2f76-11f0-b14f-a89c1698bbdd', 'ad036c14-2f76-11f0-b14f-a89c1698bbdd', 'Hi Sarah, loved your recent music release!'), -- emily_davis to sarah_wilson
(NULL, 'ad036c14-2f76-11f0-b14f-a89c1698bbdd', 'ad0369ee-2f76-11f0-b14f-a89c1698bbdd', 'Thanks Emily, that means a lot!'), -- sarah_wilson to emily_davis
(NULL, 'ad036d22-2f76-11f0-b14f-a89c1698bbdd', 'ad03704c-2f76-11f0-b14f-a89c1698bbdd', 'Hi Olivia, are you free this weekend?'), -- david_miller to olivia_hernandez
(NULL, 'ad03704c-2f76-11f0-b14f-a89c1698bbdd', 'ad036d22-2f76-11f0-b14f-a89c1698bbdd', 'Yes David, let’s plan something!'), -- olivia_hernandez to david_miller
(NULL, 'ad036e1c-2f76-11f0-b14f-a89c1698bbdd', 'ad036f48-2f76-11f0-b14f-a89c1698bbdd', 'Hi James, how’s the startup going?'), -- laura_garcia to james_martinez
(NULL, 'ad036f48-2f76-11f0-b14f-a89c1698bbdd', 'ad036e1c-2f76-11f0-b14f-a89c1698bbdd', 'Hey Laura, it’s going great! Let’s catch up soon.'), -- james_martinez to laura_garcia
(NULL, 'ad02e65e-2f76-11f0-b14f-a89c1698bbdd', 'ad036f48-2f76-11f0-b14f-a89c1698bbdd', 'Hi James, long time no see!'), -- john_doe to james_martinez
(NULL, 'ad036f48-2f76-11f0-b14f-a89c1698bbdd', 'ad02e65e-2f76-11f0-b14f-a89c1698bbdd', 'Hey John, let’s meet up soon!'); -- james_martinez to john_doe