
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT,
    user_link VARCHAR(100),
    data_of_birth DATE,
    email VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,

    CONSTRAINT PRIMARY KEY (user_id),
    CONSTRAINT UNIQUE (emaiL)
    CONSTRAINT UNIQUE (user_link)
);

CREATE TABLE Channels (
    channel_id INT AUTO_INCREMENT,
    channel_link VARCHAR(200),
    channel_dashboard
    channel_profile_pic BLOB,

    CONSTRAINT PRIMARY KEY (channel_id)
)

CREATE TABLE HomeFeeds(
    user_id INT NOT NULL,
    home_feed_id INT AUTO_INCREMENT,
    genre VARCHAR(50),

    CONSTRAINT PRIMARY KEY (user_id, home_feed_id),
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES User (user_id)
)

CREATE TABLE Videos(
    video_id INT AUTO_INCREMENT,
    video_link VARCHAR (200),
    title VARCHAR(200),
    video_description VARCHAR (5000),
    video_release_date DATETIME,
    video_length INT NOT NULL,
    content_genre VARCHAR(200),

    CONSTRAINT PRIMARY KEY (video_id)

)

CREATE TABLE VideoFeed (
    video_id INT NOT NULL,
    video_feed_id INT AUTO_INCREMENT,
    time_stamp TIME NOT_NULL,

    CONSTRAINT PRIMARY KEY (video_id, video_feed_id),
    CONSTRAINT FOREIGN KEY (video_id) REFERENCES Videos (video_id)
)

CREATE TABLE CommentSections(
    video_id INT NOT NULL,
    comment_section_id INT AUTO_INCREMENT,
    num_comments INT,

    CONSTRAINT PRIMARY KEY (video_id, comment_section-id),
    CONSTRAINT FOREIGN KEY (video_id) REFERENCES Videos (video_id)
)

CREATE TABLE Algoritihms(
    user_id INT NOT NULL,
    algorithm_id INT AUTO_INCREMENT,
    personalization_weight INT,
    watch_history INT,

    CONSTRAINT PRIMARY KEY (user_id, algorithm_id),
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES User (user_id);
)





