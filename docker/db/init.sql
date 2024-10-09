DROP TABLE IF EXISTS Game_Scores;
DROP TABLE IF EXISTS Account_Achievements;
DROP TABLE IF EXISTS Achievements;
DROP TABLE IF EXISTS Student_Progress;
DROP TABLE IF EXISTS Student_Courses;
DROP TABLE IF EXISTS Instructor_Courses;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Account_Data;
DROP TABLE IF EXISTS Accounts;

CREATE TABLE Accounts (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_instructor BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Account_Data (
    user_id INT NOT NULL,
    games_played INT DEFAULT 0,
    experience_level INT DEFAULT 0,
    PRIMARY KEY (user_id),
	FOREIGN KEY (user_id) REFERENCES Accounts(user_id) 
		ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    temporary_course_code CHAR(6) UNIQUE NOT NULL
);

CREATE TABLE Instructor_Courses (
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (user_id, course_id),
    FOREIGN KEY (user_id) REFERENCES Accounts(user_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Student_Courses (
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (user_id, course_id),
	FOREIGN KEY (user_id) REFERENCES Accounts(user_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Student_Progress (
    course_id INT NOT NULL,
    user_id INT NOT NULL,
    total_score INT DEFAULT 0,
    PRIMARY KEY (course_id, user_id),
	FOREIGN KEY (course_id) REFERENCES Courses(course_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Accounts(user_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Achievements (
    achievement_id INT AUTO_INCREMENT PRIMARY KEY,
    achievement_image VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    date_earned TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Account_Achievements (
    user_id INT NOT NULL,
    achievement_id INT NOT NULL,
    PRIMARY KEY (user_id, achievement_id),
    FOREIGN KEY (user_id) REFERENCES Accounts(user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY (achievement_id) REFERENCES Achievements(achievement_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Game_Scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    date_earned TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Accounts(user_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);