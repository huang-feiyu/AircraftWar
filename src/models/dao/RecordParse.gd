
func timestamp_to_string(timestamp):
	var time : Dictionary = OS.get_datetime_from_unix_time(timestamp)
	var display_string : String = "%d/%02d/%02d %02d:%02d" % [time.year, time.month, time.day, time.hour, time.minute]

