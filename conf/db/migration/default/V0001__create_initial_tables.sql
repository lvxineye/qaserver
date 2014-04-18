CREATE TABLE grade(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE job_title(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);



CREATE TABLE staff(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  card_id VARCHAR(255),
  name VARCHAR(50) NOT NULL,
  grade INT REFERENCES grade(id),
  position INT REFERENCES job_title(id),
  phone VARCHAR(50),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE student(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  card_id VARCHAR(255),
  name VARCHAR(50) NOT NULL,
  grade INT REFERENCES grade(id),
  address VARCHAR(255),
  gender SMALLINT,
  avatar VARCHAR(255),
  note TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE parent(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  card_id VARCHAR(255),
  name VARCHAR(50) NOT NULL,
  role VARCHAR(50) NOT NULL,
  avatar VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  created_at TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  student BIGINT REFERENCES student(id) on delete cascade
);

CREATE TABLE record(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  card_id VARCHAR(255),
  video VARCHAR(255),
  in_out INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
