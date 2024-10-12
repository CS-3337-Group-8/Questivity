DROP TABLE IF EXISTS user_achievements;
DROP TABLE IF EXISTS scores;
DROP TABLE IF EXISTS user_progress;
DROP TABLE IF EXISTS student_courses;
DROP TABLE IF EXISTS instructor_courses;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS achievements;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    name VARCHAR(255) DEFAULT "" NOT NULL,
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_instructor BOOLEAN DEFAULT FALSE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    games_played INT DEFAULT 0 CHECK (games_played >= 0),
    experience_level INT DEFAULT 0 CHECK (experience_level >= 0)
);

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code CHAR(6) DEFAULT "" UNIQUE NOT NULL
);

CREATE TABLE achievements (
    achievement_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    image VARCHAR(255),
    description TEXT NOT NULL
);

CREATE TABLE scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    score INT NOT NULL,
    course_id INT NOT NULL,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE student_courses (
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (user_id, course_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE user_progress (
    course_id INT NOT NULL,
    user_id INT NOT NULL,
    progress_score INT DEFAULT 0,
    PRIMARY KEY (course_id, user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE instructor_courses (
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (user_id, course_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE user_achievements (
    user_id INT NOT NULL,
    achievement_id INT NOT NULL,
    PRIMARY KEY (user_id, achievement_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (achievement_id) REFERENCES achievements(achievement_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert example users
INSERT INTO users (username, password_hash, is_instructor, games_played, experience_level)
VALUES 
('john_doe', 'hashed_password_1', FALSE, 10, 1),
('jane_instructor', 'hashed_password_2', TRUE, 5, 3),
('student123', 'hashed_password_3', FALSE, 20, 2);

-- Insert example courses
INSERT INTO courses (name, code)
VALUES 
('Introduction to Politics', 'POL101'),
('Game Design Basics', 'GDB102');

-- Insert example achievements
INSERT INTO achievements (name, image, description)
VALUES 
('First Quiz Completed', 'first_quiz.png', 'Complete the first quiz of the course.'),
('High Score Achiever', 'high_score.png', 'Achieve the highest score in any game.');

-- Assign instructors to courses
INSERT INTO instructor_courses (user_id, course_id)
VALUES 
((SELECT user_id FROM users WHERE username = 'jane_instructor'), 
 (SELECT course_id FROM courses WHERE code = 'POL101'));

-- Assign students to courses
INSERT INTO student_courses (user_id, course_id)
VALUES 
((SELECT user_id FROM users WHERE username = 'john_doe'), 
 (SELECT course_id FROM courses WHERE code = 'POL101')),
((SELECT user_id FROM users WHERE username = 'student123'), 
 (SELECT course_id FROM courses WHERE code = 'GDB102'));

-- Insert scores for games played by users in courses
INSERT INTO scores (score, course_id, user_id, game_id)
VALUES 
(85, (SELECT course_id FROM courses WHERE code = 'POL101'), 
     (SELECT user_id FROM users WHERE username = 'john_doe'), 1),
(92, (SELECT course_id FROM courses WHERE code = 'GDB102'), 
     (SELECT user_id FROM users WHERE username = 'student123'), 2);

-- Track progress of students in their courses
INSERT INTO user_progress (course_id, user_id, progress_score)
VALUES 
((SELECT course_id FROM courses WHERE code = 'POL101'), 
 (SELECT user_id FROM users WHERE username = 'john_doe'), 70),
((SELECT course_id FROM courses WHERE code = 'GDB102'), 
 (SELECT user_id FROM users WHERE username = 'student123'), 50);

-- Assign achievements to users
INSERT INTO user_achievements (user_id, achievement_id)
VALUES 
((SELECT user_id FROM users WHERE username = 'john_doe'), 
 (SELECT achievement_id FROM achievements WHERE name = 'First Quiz Completed')),
((SELECT user_id FROM users WHERE username = 'student123'), 
 (SELECT achievement_id FROM achievements WHERE name = 'High Score Achiever'));
