DROP TABLE accounts;

CREATE TABLE accounts (
	user_id INT PRIMARY KEY auto_increment,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, 
    is_instructor BOOLEAN NOT NULL
);

CREATE TABLE account_data (
	user_id INT,
    games_played INT NOT NULL,
    exp_level INT NOT NULL
    -- FOREIGN KEY (user_id) REFERNCES accounts(user_id)
);

CREATE TABLE courses (
course_id INT PRIMARY KEY auto_increment
);

CREATE TABLE student_progress (
progress_id INT PRIMARY KEY auto_increment
);

CREATE TABLE achievements (
achievement_id INT PRIMARY KEY auto_increment
);

CREATE TABLE game_scores (
score_id INT PRIMARY KEY auto_increment
);

/*

CREATE TABLE course_instructors (
user_id INT 
);

CREATE TABLE course_students (
user_id INT 
);
CREATE TABLE account_achievements (
user_id INT 
);
/*