import mysql.connector 
from mysql.connector import errorcode

config = {
	"user": "shubin"
	"password": "Purples$motherfolk!19"
	"host": "192.168.0.3"
	"database": "pysports"
	"raise_on_warning": True
}

try:

	db = mysql.connector.connect(**config)

	cursor = db.cursor()


	cursor.execute("SELECT player_id, first_name, last_name, team_name FROM player INNER JOIN team ON player.team_id = team.team_id")

	players = cursor.fetchall()

	print("\n -- DISPLAYING RECORDS --")

	for player in players:
		print(" PLAYER ID: {}\n First Name: {}\n Team Name: {}\n".format(player[0], player[1], player[2], player[3]))

	input("\n\n Press any key to continue...")

except mysql.connector.Error as err:

	if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
		print("	The specified username or passowrd are invalid")

	elif err.errno == errorcode.ER_BAD_DB_ERROR:
		print("	The specified database does not exist")

	else:
		print(err)

	finally:

		db.close()
