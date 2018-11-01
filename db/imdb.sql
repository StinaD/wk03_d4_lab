DROP TABLE IF EXISTS castings;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS stars;

CREATE TABLE movies (
  id SERIAL4 PRIMARY KEY,
  title TEXT,
  genre TEXT,
  budget INT4
);

CREATE TABLE stars (
  id SERIAL4 PRIMARY KEY,
  first_name TEXT,
  last_name TEXT
);

CREATE TABLE castings (
  id SERIAL4 PRIMARY KEY,
  star_id INT4 REFERENCES stars(id) ON DELETE CASCADE,
  movie_id INT4 REFERENCES movies(id) ON DELETE CASCADE,
  fee INT4
);
