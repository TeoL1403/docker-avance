DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    favorite_insult VARCHAR(255) NULL
);

INSERT INTO users (name, favorite_insult) VALUES
('Lucas Dubois', 'You are the human equivalent of Internet Explorer 6.'),
('Chloe Martin', 'Your code looks like it was written by a pigeon.'),
('Leo Bernard', 'Your logic has more holes than a phishing email.'),
('Manon Petit', 'You must be a deprecated function, because you have no support.'),
('Hugo Durand', 'Your CSS is just a series of !important tags.');