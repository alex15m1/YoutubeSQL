DROP TABLE IF EXISTS Comment;
DROP TABLE IF EXISTS CommentSection;
DROP TABLE IF EXISTS VideoFeed;
DROP TABLE IF EXISTS VideoAlgorithm;
DROP TABLE IF EXISTS HomeFeed;
DROP TABLE IF EXISTS UserNotification;
DROP TABLE IF EXISTS YTAlgorithm;
DROP TABLE IF EXISTS Video;
DROP TABLE IF EXISTS Channel;
DROP TABLE IF EXISTS User;


CREATE TABLE User (
    user_id INT AUTO_INCREMENT,
    user_link VARCHAR(100),
    data_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    user_fullname VARCHAR(100) NOT NULL,

    CONSTRAINT PRIMARY KEY (user_id),
    CONSTRAINT UNIQUE (email),
    CONSTRAINT UNIQUE (user_link)
);

CREATE TABLE Channel (
    channel_id INT AUTO_INCREMENT,
    channel_link VARCHAR(200),
    channel_age INT DEFAULT 0,
    num_subscribers INT NOT NULL,
    channel_description VARCHAR(250),
    channel_profile_pic BLOB,

    CONSTRAINT PRIMARY KEY (channel_id)
);

CREATE TABLE Video (
    video_id INT AUTO_INCREMENT,
    video_link VARCHAR(200),
    video_title VARCHAR(200),
    video_description VARCHAR(5000),
    video_release_date DATETIME,
    video_length TIME NOT NULL,
    content_genre VARCHAR(200),

    CONSTRAINT PRIMARY KEY (video_id)
    CHECK (video_length BETWEEN '00:00:00' AND '12:00:00') 

);


CREATE TABLE YTAlgorithm(
    algorithm_id INT AUTO_INCREMENT,
    watch_history INT DEFAULT 0,
    personalization_weight INT DEFAULT 0,

    CONSTRAINT PRIMARY KEY (algorithm_id)
);

CREATE TABLE UserNotification (
    notification_id INT AUTO_INCREMENT,
    notification_text VARCHAR(300) NOT NULL,
    channel_id INT NOT NULL,
    video_id INT NOT NULL,
    notification_timestamp TIMESTAMP NOT NULL,
    
    CONSTRAINT PRIMARY KEY (notification_id, channel_id, video_id),
    CONSTRAINT FOREIGN KEY (channel_id) REFERENCES Channel (channel_id)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (video_id) REFERENCES Video(video_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 
CREATE TABLE VideoAlgorithm(
    algorithm_id INT NOT NULL,
    user_id INT NOT NULL,
    video_algorithm_id INT AUTO_INCREMENT,
    
    CONSTRAINT PRIMARY KEY (algorithm_id, video_algorithm_id, user_id),
    CONSTRAINT FOREIGN KEY (algorithm_id) REFERENCES Algorithm (algorithm_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES User (user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- User_id represents a user, home feed's creation is based on the user
CREATE TABLE HomeFeed(
    user_id INT NOT NULL,
    home_feed_id INT AUTO_INCREMENT,
    algorithm_id INT NOT NULL,
    
    CONSTRAINT PRIMARY KEY (user_id, home_feed_id, algorithm_id),
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES User (user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (algorithm_id) REFERENCES Algorithm (algorithm_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- TESTING if REFERENCES Algorithm works, currently marked as keyword
CREATE TABLE VideoFeed (
    video_id INT NOT NULL,
    video_feed_id INT AUTO_INCREMENT,
    time_stamp TIME NOT_NULL,
    video_algorithm_id INT NOT NULL,

    CONSTRAINT PRIMARY KEY (video_id, video_feed_id),
    CONSTRAINT FOREIGN KEY (video_id) REFERENCES Videos (video_id),
    CONSTRAINT FOREIGN KEY (video_algorithm_id) REFERENCES Algorithm (video_algorithm_id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
 
);

CREATE TABLE CommentSection(
    video_id INT NOT NULL,
    comment_section_id INT AUTO_INCREMENT,
    num_comments INT DEFAULT 0,

    CONSTRAINT PRIMARY KEY (video_id, comment_section-id),
    CONSTRAINT FOREIGN KEY (video_id) REFERENCES Videos (video_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Comment (
    comment_id INT NOT NULL, 
    comment_char_length VARCHAR(10000),
    comment_timestamp TIMESTAMP NOT NULL,
    comment_section_id INT NOT NULL,
    user_id INT NOT NULL,

    CONSTRAINT PRIMARY KEY (comment_id, user_id, comment_section_id),
    CONSTRAINT FOREIGN KEY (comment_section_id) REFERENCES CommentSection(comment_section_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES User(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- 1. USER
INSERT INTO User
    (user_id, user_link, data_of_birth, email, user_fullname)
VALUES
    (1, 'youtube.com/@alex', '2001-05-15',
     'alex@example.com', 'Alex Martinez'),
    (2, 'youtube.com/@john', '1999-08-22',
     'john@example.com', 'John Smith'),
    (3, 'youtube.com/@sarah', '2002-11-10',
     'sarah@example.com', 'Sarah Johnson');


-- 2. CHANNEL
INSERT INTO Channel
    (channel_id, channel_link, channel_age,
     num_subscribers, channel_description, channel_profile_pic)
VALUES
    (1, 'youtube.com/@techworld', 5, 15000,
     'Technology tutorials and programming', NULL),
    (2, 'youtube.com/@gaminghub', 3, 8500,
     'Gaming videos and reviews', NULL),
    (3, 'youtube.com/@fitnesslife', 2, 4200,
     'Fitness and workout tutorials', NULL);


-- 3. VIDEO
INSERT INTO Video
    (video_id, video_link, video_title,
     video_description, video_release_date,
     video_length, content_genre)
VALUES
    (1, 'youtube.com/watch?v=abc123',
     'Introduction to Programming',
     'Beginner programming tutorial',
     '2026-09-01 12:00:00', '00:15:30', 'Education'),

    (2, 'youtube.com/watch?v=def456',
     'Top 10 Games of 2026',
     'Reviewing the best games',
     '2026-09-10 15:30:00', '00:22:15', 'Gaming'),

    (3, 'youtube.com/watch?v=ghi789',
     'Full Body Workout',
     'Beginner workout routine',
     '2026-09-15 09:00:00', '00:30:00', 'Fitness');


-- 4. USER NOTIFICATION
INSERT INTO UserNotification
    (notification_id, notification_text,
     channel_id, video_id, notification_timestamp)
VALUES
    (1, 'TechWorld uploaded a new video!',
     1, 1, '2026-09-01 12:05:00'),

    (2, 'GamingHub uploaded a new video!',
     2, 2, '2026-09-10 15:35:00'),

    (3, 'FitnessLife uploaded a new video!',
     3, 3, '2026-09-15 09:05:00');


-- 5. ALGORITHM
INSERT INTO Algorithm
    (algorithm_id, watch_history, personalization_weight)
VALUES
    (1, 15, 80),
    (2, 25, 90),
    (3, 10, 65);


-- 6. VIDEO ALGORITHM
INSERT INTO VideoAlgorithm
    (algorithm_id, user_id, video_algorithm_id)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3);


-- 7. HOME FEED
INSERT INTO HomeFeed
    (user_id, home_feed_id, algorithm_id)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3);


-- 8. VIDEO FEED
INSERT INTO VideoFeed
    (video_id, video_feed_id, time_stamp,
     video_algorithm_id)
VALUES
    (1, 1, '12:00:00', 1),
    (2, 2, '15:30:00', 2),
    (3, 3, '09:00:00', 3);


-- 9. COMMENT SECTION
INSERT INTO CommentSection
    (video_id, comment_section_id, num_comments)
VALUES
    (1, 1, 2),
    (2, 2, 1),
    (3, 3, 1);


-- 10. COMMENT
INSERT INTO Comment
    (comment_id, comment_char_length,
     comment_timestamp, comment_section_id, user_id)
VALUES
    (1, 'Great programming tutorial!',
     '2026-09-01 13:00:00', 1, 2),

    (2, 'Very helpful explanation.',
     '2026-09-01 14:30:00', 1, 3),

    (3, 'I love these games!',
     '2026-09-10 17:00:00', 2, 1),

    (4, 'Great workout routine!',
     '2026-09-15 10:00:00', 3, 2);


