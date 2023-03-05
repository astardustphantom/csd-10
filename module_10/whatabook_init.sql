
    --Title: whatabook.init.sql
    --Author: Shubin, Lindsay
    --Date of last update: 04 March 2023
    --Description: WhatABook database initialization script.


--drop potential users under this description
--create user and assign privileges

DROP USER IF EXISTS 'whatabook_user'@'localhost';

UPDATE USER 'whatabook_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Purples$motherfolk!19';

GRANT ALL PRIVILEGES ON whatabook.* TO'whatabook_user'@'localhost';

-- create tables for users and assign parameters

CREATE TABLE user (
     user_id INT     NOT NULL        AUTO_INCREMENT,
     first_name      VARCHAR(75)     NOT NULL,
     last_name       VARCHAR(75)     NOT NULL,
     PRIMARY KEY(user_id)
    );

-- creating further tables and assigning criteria to these as well

CREATE TABLE store (
    store_id        INT     NOT NULL        AUTO_INCREMENT,
    locale  VARCHAR(500)    NOT NULL,
    PRIMARY KEY(store_id)
   );


CREATE TABLE book (
     book_id INT     NOT NULL        AUTO_INCREMENT,
     book_name       VARCHAR(200)    NOT NULL,
     author  VARCHAR(200)    NOT NULL,
     details VARCHAR(500),
     PRIMARY KEY(book_id)
    );

-- ensuring that the foreign key exists to relate tables 

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
    
ALTER TABLE wishlist DROP FOREIGN KEY fk_book;

-- instert data into tables

INSERT INTO store(locale)
     VALUES('616 Ruger Rd, Chicago, IL 60602');


INSERT INTO book(book_name, author, details)
     VALUES('Information Technology for Counterterrorism', 'National Research Council', 'Immediate actions and future possibilities');


INSERT INTO book(book_name, author)
     VALUES('The Martian', 'Andy Weir');


INSERT INTO book(book_name, author)
     VALUES('Edgar Allen Poe Classic Stories', 'Edgar Allen Poe');


INSERT INTO book(book_name, author)
     VALUES('Learn Latin', 'Peter Jones');


INSERT INTO book(book_name, author)
         VALUES('Emotional Intelligence', 'Dr. David Walton');


INSERT INTO book(book_name, author)
     VALUES('Ancient Egypt', 'David P. Silverman');


INSERT INTO book(book_name, author, details)
     VALUES('A Dictionary of Angels', 'Gustav Davidson', 'Including the fallen angels');


INSERT INTO book(book_name, author)
     VALUES('The Killer Book of Serial Killers', 'Tom Philbin and Michael Philbin');


INSERT INTO book(book_name, author, details)
     VALUES('The Pacific, Volume One, Pearl Harbor to Guadalcanal', 'Jay Wertz', 'War stories');


INSERT INTO user(first_name, last_name)
     VALUES('Lindsay', 'Shubin');


INSERT INTO user(first_name, last_name)
     VALUES('Tony', 'DiNozzo');


INSERT INTO user(first_name, last_name)
     VALUES('Gaylord', 'Montgomery');

-- assign books to user wishlists

INSERT INTO wishlist(user_id, book_id)
     VALUES(
             (SELECT user_id FROM user WHERE first_name = 'Lindsay'),
             (SELECT user_id FROM book WHERE book_name = 'Information Technology for Counterterrorism')
    );


INSERT INTO wishlist(user_id, book_id)
     VALUES(
             (SELECT user_id FROM user WHERE first_name = 'Tony'),
             (SELECT book_id FROM book WHERE book_name = 'The Killer Book of Serial Killers')
    );


INSERT INTO wishlist(user_id, book_id)
     VALUES(
             (SELECT user_id FROM user WHERE first_name = 'Gaylord'),
             (SELECT book_id FROM book WHERE book_name = 'The Pacific, Volume One, Pearl Harbor to Guadalcanal')
    );


