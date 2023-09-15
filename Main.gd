extends Node2D

onready var font = load("res://20otf.tres")
onready var data = {}
var current_tv_name
func _on_add_pressed():
	
	var title = $Input/title.text
	var all_progress = $Input/jishu.text
	
	var side_title_instance = Label.new()
	side_title_instance.text = title + "[0" +"/" + all_progress + "]"
	side_title_instance.set("custom_fonts/font",font)
	side_title_instance.set("mouse_filter",Control.MOUSE_FILTER_PASS)
	$side/VBoxContainer.add_child(side_title_instance)
	
	side_title_instance.connect("gui_input",self,"_on_side_title_pressed",[title,all_progress])
	pass

func _on_side_title_pressed(event,p_title,p_all_progress):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			for node in $TvInfo.get_children():
				node.queue_free()
			current_tv_name = p_title
			var title = Label.new()
			title.set("custom_fonts/font",font)
			title.text = p_title
			var prog = ProgressBar.new()
			prog.set("max_value",p_all_progress)
			$TvInfo.add_child(title)
			for index in range(p_all_progress):
				var check = CheckBox.new()
				check.connect("toggled",self,"_on_single_check_toggled",[check,p_all_progress])
				check.text = str(index)
				$TvInfo.add_child(check)
			$TvInfo.add_child(prog)
			
func _on_single_check_toggled(p_toggled,p_check,p_all_progress):
	var current_progress = 0
	current_progress +=1
	var index = int(p_check.text)
#	var watched_array = []
#	watched_array.resize(p_all_progress)
#	watched_array[index]=p_toggled
#	data[""+current_tv_name+""]={"watched":watched_array}
	
#	data[current_tv_name].watched[int(p_check.text)] = p_toggled
	data[""+current_tv_name+""]={"current_progress":current_progress,"all_progress":p_all_progress}
	print(data)
	save()
	
	pass
	
func save():
	var data_file = File.new()
	data_file.open("user://data.json",File.WRITE_READ)
	data_file.store_string(to_json(data))
	data_file.close()
	pass
