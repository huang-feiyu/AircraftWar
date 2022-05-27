extends Control

var seleted_row
# array:[id:int, name:str, score:int, date:str]
# id is unique int (record id)
var table_array

func _ready():
	$Table.hide()
	$DifficultyLabel.hide()

# click to pop up dialog to ensure deletion
func _on_Table_CLICK_ROW(value):
	seleted_row = value
	$DeletionConfirm.dialog_text = "Are you sure to delete this record " + str(value) + "?"
	$DeletionConfirm.show()
	show_represent_table()

func _on_DeletionConfirm_confirmed():
	delete_row()
	show_represent_table()
	$DeletionConfirm.hide()

# table_array => represent_table
func show_represent_table():
	table_array = $Sqlite.read_record_from_db()
	var represent_table = []
	for i in range(table_array.size()):
		represent_table.append([i + 1, table_array[i][1], # rank, name
								str(table_array[i][2]), # score
								table_array[i][3], # date
								str(table_array[i][0])]) # id
	$Table.set_rows(represent_table)

# delete a row
func delete_row():
	print("ready to delete: ", seleted_row)
	for i in range(table_array.size()):
		if int(seleted_row[4]) == table_array[i][0]:
			table_array.remove(i)
			$Sqlite.delete_record_from_db(seleted_row[4])
			break

# start
func start():
	$Sqlite.write_record_to_db(GameManager.user_name)
	$DifficultyLabel.text =("\nEasy" if GameManager.difficulty == 0 else\
							"\nNormal" if GameManager.difficulty == 1 else\
							"\nHard") + " Mode"
	$Table.show()
	$DifficultyLabel.show()
	show_represent_table()

# end
func end():
	$Table.hide()
	$DeletionConfirm.hide()
	$DifficultyLabel.hide()
