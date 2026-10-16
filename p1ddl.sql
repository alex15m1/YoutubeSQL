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

