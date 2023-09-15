extends Node2D

onready var font = load("res://20otf.tres")

func _ready():
	pass
	
func _on_add_pressed():
	var title = $Input/title.text
	var all_progress = $Input/jishu.text
	$View.sync_info(title,all_progress)
	pass


func _on_read_pressed():
#	print("读取存档")
	var data_file = File.new()
	data_file.open("user://data.json",File.READ)
	Global.data = parse_json(data_file.get_as_text())
	for key in Global.data.keys():
#		print(key)
		$View.add_side_btn(key)
	pass
