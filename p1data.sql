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
