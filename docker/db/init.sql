CREATE TABLE Accounts (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_instructor BOOLEAN DEFAULT FALSE
);

CREATE TABLE Account_Data (
    user_id INT REFERENCES Accounts(user_id),
    games_played INT DEFAULT 0,
    experience_level INT DEFAULT 0,
    PRIMARY KEY (user_id)
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    temporary_course_code CHAR(6) UNIQUE NOT NULL
);

CREATE TABLE Instructor_Courses (
    user_id INT REFERENCES Accounts(user_id),
    course_id INT REFERENCES Courses(course_id),
    PRIMARY KEY (user_id, course_id)
);

CREATE TABLE Student_Courses (
    user_id INT REFERENCES Accounts(user_id),
    course_id INT REFERENCES Courses(course_id),
    PRIMARY KEY (user_id, course_id)
);

CREATE TABLE Student_Progress (
    course_id INT REFERENCES Courses(course_id),
    user_id INT REFERENCES Accounts(user_id),
    total_score INT DEFAULT 0,
    PRIMARY KEY (course_id, user_id)
);

CREATE TABLE Achievements (
    achievement_id SERIAL PRIMARY KEY,
    achievement_image VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    date_earned DATE
);

CREATE TABLE Account_Achievements (
    user_id INT REFERENCES Accounts(user_id),
    achievement_id INT REFERENCES Achievements(achievement_id),
    PRIMARY KEY (user_id, achievement_id)
);

CREATE TABLE Game_Scores (
    score_id SERIAL PRIMARY KEY,
    course_id INT REFERENCES Courses(course_id),
    user_id INT REFERENCES Accounts(user_id),
    game_id INT NOT NULL,
    date_earned DATE
);
