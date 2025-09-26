INSERT INTO Users (username, password, email)
VALUES ('testuser', '1234', 'test@example.com');

INSERT INTO Albums (user_id, title, artist, genre, year)
VALUES (1, 'Hybrid Theory', 'Linkin Park', 'Nu Metal', 2000);

INSERT INTO Tracks (album_id, title, duration)
VALUES (1, 'Papercut', '3:04');

INSERT INTO Tracks (album_id, title, duration)
VALUES (1, 'One Step Closer', '2:36');

COMMIT;
