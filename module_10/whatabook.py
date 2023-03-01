#Title: whatabook.py
#Author: Lindsay Shubin
#Date 28 Feb 2023
#Description: Python code supporting business rules for whatabook database

# import and connection statements
import sys
import mysql.connector 
import errorcode

# database config
config = {
	"user": "whatabook_user",
	"password": "Purples$motherfolk!19"
	"host": "192.168.0.3"
	"database": "whatabook"
	"raise_on_warnings": True
}

def show_menu():
	print("\n -- Main Menu --")

	print("	1. View Books\n 	2. View Store Locations\n 	3. My Account\n 	4. Exit Program")

	try:
		choice = int(input('	'))

		return choice
	except ValueError:
		print("\n Please try a different value. Restarting now \n")

		sys.exit

	def show_books(_cursor):
		# inner join
		_cursor.execute("SELECT book_id, book_name, author, details")

		# results
		books = _cursor.fetchall()

		print("\n -- Displaying Books --")

		# displaying results of user query for books
		for book in books:
			print(" Book Name: {}\n Author: {}\n Deatails: {}\n".format(book[0], book[1], book[2]))

	def show_locations(_cursor):
		_cursor.execute("SELECT store_id, locale")

		locations = _cursor.fetchall()

		print("\n -- Displaying Store Locations --")

		for location in locations:
			print(" Locale: {}\n".format(location[1]))

	def validate_user():
		# validate user

		try:
			user_id = int(input('\n Please enter the user ID number for your account'))

				if user_id < 0 or user_id > 3:
					print("\n Invalid user ID, please restart \n")

					sys.exit(0)

	def show_account_menu():

		try:

			print("\n -- Customer Menu --")
			print(" 1. Wishlist\n 	2. Add Book\n 	3. Main Menu")
			account_option = int(input(	' : '))

			return account_option

		except ValueError:
			print("\n Invalid number, please restart \n")

			sys.exit(0)

	def show_wishlist(_cursor, _user_id):
		# database query fir books added to user wishlist

		_cursor.execute("SELECT user.user_id, user.first_name, user.last_name, book.book_id, book.book_name, book.author " + 
						"FROM wishlist " +
						"INNER JOIN user ON wishlist.user_id = user.user_id " +
						"INNER JOIN user ON wishlist.book_id = book.book_id " +
						"WHERE user.user_id = {}".format(_user_id))

		wishlist = _cursor.fetchall()

		print("\n -- Displaying Wishlist -- ")

		for book in wishlist:
			print(" Book Name: {}\n Author {}\n".format(book[4], book[5]))

	def show_books_to_add(_cursor, _user_id):
		# query databse for wishlist 

		query = ("SELECT book_id, book_name, author, details "
				"FROM book "
				"WHERE book_id NOT IN (SELECT book_id FROM wishlist WHERE user_id = {})".format(_user_id))

		print(query)

		_cursor.execute(query)

		books_to_add = cursor.fetchall()

		print("n\ -- DISPLAYING AVAILABLE BOOKS --")

		for book in books_to_add:
			print(" Book ID: {}\n Book Name: {}\n".format(book[0], book[1]))

	def add_book_to_wishlist(_cursor, _user_id, _book_id):
		_cursor.execute("INSERT INTO wishlist(user_id, book_id) VALUES({}, {})".format(_user_id, _book_id))


def validate_user():
	pass


try:
		#try/catch for handling MySQL database errors

		db = mysql.connector.connect(**config) # connecting to the whatabook database

		cursor = db.cursor() # MySQL queries

		print("\n Welcome to WhatABook ")

		user_selection = show_menu() # displaying main menu

		# user option selection

		while user_selection != 4:

			# if selection is 1, display book list

			if user_selection == 1:
				show_books(cursor)

			# if selection is 2, display store locations

			if user_selection == 2:
				show_locations(cursor)

			# if selection is 3, validate user

			if user_selection == 3:
				my_user_id = validate_user()
				account_option = show_account_menu()

				while account_option != 3:

					# if selection is option 1, display user wishlist

					if account_option ==1:
						show_wishlist(cursor, my_user_id)


					# if selection is option 2, call show_books_to_add to show uesr books not currently in wishlist

					if account_option == 2:

						show_books_to_add(cursor, my_user_id)

						book_id = int(input("\n Enter the id of the book you would like to add: "))

						add_book_to_wishlist(cursor, my_user_id, book_id)

						# commit changes to database

						db.commit() 

						print("\n Book ID: {} has been successfully added to your wishlist ".format(book_id))

					# if selected option is less than 0 or greater than 4, indicate error

					if user_selection < 0 or user_selection > 4:
						print("\n Invalid option ")

					#display main menu

					user_selection = show_menu()

				print("\n\n Please restart ")

			except mysql.connector.Error as err:

			# error handling

				if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
					print(" Incorrect username or password ")

				elif err.errno == errorcode.ER_BAD_DB_ERROR:
					print(" This database does not exist")

				else:
					print(err)

			finally:

			# exit databse connection

				db.close()





