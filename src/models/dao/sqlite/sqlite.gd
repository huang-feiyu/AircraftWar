extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var db
var db_name := "res://data/test.db"

func _ready():
	if OS.get_name() in ["Android", "iOS", "HTML5"]:
		copy_data_to_user()
		db_name = "user://data/test.db"
	db = SQLite.new()
	db.path = db_name

func copy_data_to_user():
	var data_path := "res://data"
	var copy_path := "user://data"

	var dir = Directory.new()
	dir.make_dir(copy_path)
	if dir.open(data_path) == OK:
		dir.list_dir_begin();
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				pass
			else:
				print("Copying " + file_name + " to /user-folder")
				dir.copy(data_path + "/" + file_name, copy_path + "/" + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func read_record_from_db():
	var difficulty = GameManager.difficulty
	db.open_db()
	db.query("SELECT score_record.id AS id, score_record.date AS date, " +\
			"score_record.score AS score, user_info.name AS name " +\
			"FROM score_record LEFT JOIN user_info " +\
			"ON score_record.user_id = user_info.id " +\
			"WHERE valid_bit = 0 AND " + "difficulty = " + str(difficulty) + ";")
	var table_array = []
	for i in range(db.query_result.size()):
		db.query_result[i]["date"] = timestamp_to_string(db.query_result[i]["date"])
		table_array.append([db.query_result[i]["id"], db.query_result[i]["name"],\
							db.query_result[i]["score"], db.query_result[i]["date"]])
	table_array.sort_custom(CustomSorter, "sort_according_score")
	return table_array

func write_record_to_db(name):
	db.open_db()
	var dict : Dictionary = Dictionary()
	dict["score"] = GameManager.score
	dict["difficulty"] = GameManager.difficulty
	dict["user_id"] = user_name2user_id(name)
	dict["date"] = OS.get_unix_time()
	db.insert_row("score_record", dict)

func delete_record_from_db(id):
	db.open_db()
	print("update row: ", db.update_rows("score_record", "id = " + str(id), {"valid_bit": 1}))

func write_account_to_db(name, psw):
	db.open_db()
	var dict : Dictionary = Dictionary()
	dict["name"] = name
	dict["password"] = psw
	db.insert_row("user_info", dict)

func read_account_from_db(name, psw):
	db.open_db()
	db.query("SELECT * FROM user_info WHERE name = '" + name + "';")
	if db.query_result.size() == 0:
		write_account_to_db(name, psw)
		db.query("SELECT * FROM user_info WHERE name = '" + name + "';")
	return db.query_result[0]["password"] == psw

func timestamp_to_string(timestamp):
	var time : Dictionary = OS.get_datetime_from_unix_time(timestamp)
	var display_string : String = "%d/%02d/%02d %02d:%02d" % [time.year, time.month, time.day, time.hour, time.minute]
	return display_string

func user_name2user_id(name):
	db.open_db()
	db.query("SELECT * FROM user_info WHERE name = '" + name + "';")
	if db.query_result.size() == 0:
		db.insert_row("user_info", {"name": name})
		db.query("SELECT * FROM user_info WHERE name = '" + name + "';")
	return db.query_result[0]["id"]

class CustomSorter:
	static func sort_according_score(a, b):
		if a[2] > b[2]:
			return true
		else:
			return false
