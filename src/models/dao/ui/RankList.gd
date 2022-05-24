extends Control

var seleted_row
# array:[id:int, name:str, score:int, date:str]
# id is unique int
var table_array = [ [1,  'huang', 100, '22-05-18'],
					[2,  'huang',  99, '22-05-20'],
					[3,  'huang',  98, '22-05-20'],
					[4,  'huang',  97, '22-05-20'],
					[5,  'huang',  96, '22-05-20'],
					[6,  'huang',  95, '22-05-20'],
					[7,  'huang',  94, '22-05-20'],
					[8,  'huang',  93, '22-05-20'],
					[9,  'huang',  92, '22-05-20'],
					[10, 'huang',  91, '22-05-20'],
					[11, 'huang',  90, '22-05-20'],
					[12, 'huang',  89, '22-05-20'],
					[13, 'huang',  88, '22-05-20'],
					[14, 'huang',  87, '22-05-20'],
					[299,  'huang',  86, '22-05-20'],
					[399,  'huang',  85, '22-05-20'],
					[499,  'huang',  84, '22-05-20'],
					[599,  'huang',  90, '22-05-20'],
					[699,  'huang',  90, '22-05-20'],
					[799,  'huang',  90, '22-05-20'],
					[899,  'huang',  90, '22-05-20'],
					[999,  'huang',  90, '22-05-20'],
					[1090, 'huang',  90, '22-05-20'],
					[1190, 'huang',  90, '22-05-20'],
					[1290, 'huang',  90, '22-05-20'],
					[1390, 'huang',  90, '22-05-20'],
					[1490, 'huang',  90, '22-05-20'],
					[3290,  'huang',  90, '22-05-20'],
					[8390,  'huang',  90, '22-05-20'],
					[8390,  'huang',  90, '22-05-20'],
					[8590,  'huang',  90, '22-05-20'],
					[9690,  'huang',  90, '22-05-20'],
					[8790,  'huang',  90, '22-05-20'],
					[8890,  'huang',  90, '22-05-20'],
					[3990,  'huang',  90, '22-05-20'],
					[1109, 'huang',  90, '22-05-20'],
					[1119, 'huang',  90, '22-05-20'],
					[2129, 'huang',  90, '22-05-20'],
					[139999, 'huang',  90, '22-05-20'],
					[149999, 'huang',  90, '22-05-20'],
					[159999, 'huang',  90, '22-05-20'],
					[169999, 'huang',  90, '22-05-20'],
					[179999, 'huang',  90, '22-05-20'],
					[189999, 'huang',  90, '22-05-20'],
					[199999, 'huang',  90, '22-05-20'],
					[209999, 'huang',  90, '22-05-20'],
					[219999, 'huang',  90, '22-05-20'],
					[229999, 'huang',  90, '22-05-20']]

signal restart

func _ready():
	$Table.hide()
	$DifficultyLabel.hide()

# click to pop up dialog to ensure deletion
func _on_Table_CLICK_ROW(value):
	seleted_row = value
	$DeletionConfirm.show()
	show_represent_table()

func _on_DeletionConfirm_confirmed():
	delete_row()
	show_represent_table()
	$DeletionConfirm.hide()

func _on_Timer_timeout():
	$Timer.stop()

# table_array => represent_table
func show_represent_table():
	var represent_table = []
	# TODO: need a sort
	for i in range(table_array.size()):
		represent_table.append([i, table_array[i][1], # rank, name
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
			break

# start
func start():
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
	$Timer.stop()
