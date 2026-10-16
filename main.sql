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
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    user_fullname VARCHAR(100) NOT NULL,

    CONSTRAINT PRIMARY KEY (user_id), 
    UNIQUE (email),
    UNIQUE (user_link)
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
    channel_id INT NOT NULL,

    CONSTRAINT PRIMARY KEY (video_id),
    CHECK (video_length BETWEEN '00:00:00' AND '12:00:00'),
    CONSTRAINT FOREIGN KEY (channel_id)
        REFERENCES Channel(channel_id)

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
    notification_timestamp TIMESTAMP NOT NULL,
    channel_id INT NOT NULL,
    video_id INT NOT NULL,
    user_id INT NOT NULL,
    
    CONSTRAINT PRIMARY KEY (notification_id, channel_id, video_id),
    CONSTRAINT FOREIGN KEY (channel_id) REFERENCES Channel (channel_id)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (video_id) REFERENCES Video(video_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (user_id)
        REFERENCES User(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 
CREATE TABLE VideoAlgorithm(
    video_algorithm_id INT AUTO_INCREMENT,
    algorithm_id INT NOT NULL,
    user_id INT NOT NULL,
    
    CONSTRAINT PRIMARY KEY (video_algorithm_id, algorithm_id, user_id),
    CONSTRAINT FOREIGN KEY (algorithm_id) REFERENCES YTAlgorithm (algorithm_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES User (user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- User_id represents a user, home feed's creation is based on the user
CREATE TABLE HomeFeed(
    home_feed_id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    algorithm_id INT NOT NULL,
    
    CONSTRAINT PRIMARY KEY (home_feed_id, user_id, algorithm_id),
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES User (user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (algorithm_id) REFERENCES YTAlgorithm (algorithm_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- TESTING if REFERENCES Algorithm works, currently marked as keyword
CREATE TABLE VideoFeed (
    video_feed_id INT AUTO_INCREMENT,
    video_id INT NOT NULL,
    time_stamp TIME NOT NULL,
    video_algorithm_id INT NOT NULL,

    CONSTRAINT PRIMARY KEY (video_feed_id, video_id),
    CONSTRAINT FOREIGN KEY (video_id) REFERENCES Video (video_id),
    CONSTRAINT FOREIGN KEY (video_algorithm_id) REFERENCES VideoAlgorithm (video_algorithm_id) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
 
);

CREATE TABLE CommentSection(
    comment_section_id INT AUTO_INCREMENT,
    video_id INT NOT NULL,
    num_comments INT DEFAULT 0,

    CONSTRAINT PRIMARY KEY (comment_section_id, video_id),
    CONSTRAINT FOREIGN KEY (video_id) REFERENCES Video (video_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);



CREATE TABLE Comment (
    comment_id INT AUTO_INCREMENT, 
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
    (user_id, user_link, date_of_birth, email, user_fullname)
VALUES
    (1, 'youtube.com/@mike87', '2000-03-12',
     'mike87@gmail.com', 'Mike Anderson'),
    (2, 'youtube.com/@jessica22', '2001-07-19',
     'jessica22@gmail.com', 'Jessica Miller'),
    (3, 'youtube.com/@david45', '1998-11-05',
     'david45@gmail.com', 'David Wilson');


-- 2. CHANNEL
INSERT INTO Channel
    (channel_id, channel_link, channel_age,
     num_subscribers, channel_description, channel_profile_pic)
VALUES
    (1, 'youtube.com/@pcbuilds', 4, 12500,
     'PC builds, parts, and reviews', NULL),
    (2, 'youtube.com/@randomgaming', 2, 6300,
     'Gaming clips and playthroughs', NULL),
    (3, 'youtube.com/@homecooking', 6, 9800,
     'Cooking videos and recipes', NULL);


-- 3. VIDEO
INSERT INTO Video
    (video_id, video_link, video_title,
     video_description, video_release_date,
     video_length, content_genre, channel_id)
VALUES
    (1, 'youtube.com/watch?v=abc123',
     'Building a Budget Gaming PC',
     'Putting together a gaming PC for under $700',
     '2026-09-01 12:00:00', '00:18:42', 'Technology', 1),

    (2, 'youtube.com/watch?v=def456',
     'Minecraft Survival Part 1',
     'Starting a new survival world',
     '2026-09-10 15:30:00', '00:24:16', 'Gaming', 2),

    (3, 'youtube.com/watch?v=ghi789',
     'Making Homemade Pizza',
     'Making pizza dough and sauce from scratch',
     '2026-09-15 09:00:00', '00:12:35', 'Cooking', 3);


-- 4. USER NOTIFICATION
INSERT INTO UserNotification
    (notification_id, notification_text,
     notification_timestamp, channel_id, video_id, user_id)
VALUES
    (1, 'PC Builds posted a new video',
     '2026-09-01 12:05:00', 1, 1, 1),

    (2, 'Random Gaming posted a new video',
     '2026-09-10 15:35:00', 2, 2, 2),

    (3, 'Home Cooking posted a new video',
     '2026-09-15 09:05:00', 3, 3, 3);


-- 5. YT ALGORITHM
INSERT INTO YTAlgorithm
    (algorithm_id, watch_history, personalization_weight)
VALUES
    (1, 12, 75),
    (2, 28, 85),
    (3, 9, 60);


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
    (video_feed_id, video_id, time_stamp,
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
    (1, 'What graphics card did you use?',
     '2026-09-01 13:00:00', 1, 2),

    (2, 'Pretty good build for the price',
     '2026-09-01 14:30:00', 1, 3),

    (3, 'You should build a house near spawn',
     '2026-09-10 17:00:00', 2, 1),

    (4, 'How long did you let the dough rise?',
     '2026-09-15 10:00:00', 3, 2);
