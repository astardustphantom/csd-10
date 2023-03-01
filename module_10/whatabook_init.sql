USE whatabook;

UPDATE USER 'whatabook_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Purples$motherfolk!19';

CREATE TABLE user (
     user_id INT     NOT NULL        AUTO_INCREMENT,
     first_name      VARCHAR(75)     NOT NULL,
     last_name       VARCHAR(75)     NOT NULL,
     PRIMARY KEY(user_id)
    );
Query OK, 0 rows affected (0.05 sec)

GRANT ALL PRIVILEGES ON whatabook.* TO'whatabook_user'@'localhost';
Query OK, 0 rows affected (0.01 sec)

ALTER TABLE wishlist DROP FOREIGN KEY fk_book;

CRETE TABLE book (
    ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'CRETE TABLE book (' at line 1
CREATE TABLE book (
     book_id INT     NOT NULL        AUTO_INCREMENT,
     book_name       VARCHAR(200)    NOT NULL,
     author  VARCHAR(200)    NOT NULL,
     details VARCHAR(500),
     PRIMARY KEY(book_id)
    );
Query OK, 0 rows affected (0.01 sec)

CREATE TABLE wishlist (
     wishlist_id     INT     NOT NULL        AUTO_INCREMENT,
     user_id INT     NOT NULL,
     book_id INT     NOT NULL,
     PRIMARY KEY (wishlist_id),
     CONSTRAINT fk_book
     FOREIGN KEY (book_id)
             REFERENCES book(book_id),
     CONSTRAINT fk_user
     FOREIGN KEY (user_id)
             REFERENCES user(user_id)
    );
Query OK, 0 rows affected (0.04 sec)

INSERT INTO store(locale)
     VALUES('616 Ruger Rd, Chicago, IL 60602');
Query OK, 1 row affected (0.01 sec)

INSERT INTO book(book_name, author, details)
     VALUES('Information Technology for Counterterrorism', 'National Research Council', 'Immediate actions and future possibilities');
Query OK, 1 row affected (0.01 sec)

INSERT INTO book(book_name, author)
     VALUES('The Martian', 'Andy Weir');
Query OK, 1 row affected (0.01 sec)

INSERT INTO book(book_name, author)
     VALUES('Edgar Allen Poe Classic Stories', 'Edgar Allen Poe');
Query OK, 1 row affected (0.00 sec)

INSERT INTO book(book_name, author)
     VALUES('Learn Latin', 'Peter Jones');
Query OK, 1 row affected (0.01 sec)

INSERT INTO book(book_name, author)
         VALUES('Emotional Intelligence', 'Dr. David Walton');
Query OK, 1 row affected (0.01 sec)

INSERT INTO book(book_name, author)
     VALUES('Ancient Egypt', 'David P. Silverman');
Query OK, 1 row affected (0.00 sec)

INSERT INTO book(book_name, author, details)
     VALUES('A Dictionary of Angels', 'Gustav Davidson', 'Including the fallen angels');
Query OK, 1 row affected (0.01 sec)

INSERT INTO book(book_name, author)
     VALUES('The Killer Book of Serial Killers', 'Tom Philbin and Michael Philbin');
Query OK, 1 row affected (0.01 sec)

INSERT INTO book(book_name, author, details)
     VALUES('The Pacific, Volume One, Pearl Harbor to Guadalcanal', 'Jay Wertz', 'War stories');
Query OK, 1 row affected (0.01 sec)

INSERT INTO user(first_name, last_name)
     VALUES('Lindsay', 'Shubin');
Query OK, 1 row affected (0.01 sec)

INSERT INTO user(first_name, last_name)
     VALUES('Tony', 'DiNozzo');
Query OK, 1 row affected (0.01 sec)

INSERT INTO user(first_name, last_name)
     VALUES('Gaylord', 'Montgomery');
Query OK, 1 row affected (0.01 sec)

INSERT INTO wishlist(user_id, book_id)
     VALUES(
             (SELECT user_id FROM user WHERE first_name = 'Lindsay'),
             (SELECT user_id FROM book WHERE book_name = 'Information Technology for Counterterrorism')
    );
Query OK, 1 row affected (0.01 sec)

INSERT INTO wishlist(user_id, book_id)
     VALUES(
             (SELECT user_id FROM user WHERE first_name = 'Tony'),
             (SELECT book_id FROM book WHERE book_name = 'The Killer Book of Serial Killers')
    );
Query OK, 1 row affected (0.01 sec)

INSERT INTO wishlist(user_id, book_id)
     VALUES(
             (SELECT user_id FROM user WHERE first_name = 'Gaylord'),
             (SELECT book_id FROM book WHERE book_name = 'The Pacific, Volume One, Pearl Harbor to Guadalcanal')
    );
Query OK, 1 row affected (0.01 sec)

