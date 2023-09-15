extends Node2D

onready var font = load("res://20otf.tres")
var checkbox_states = {}  # 用于保存CheckBox的状态

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
			var title = Label.new()
			title.set("custom_fonts/font",font)
			title.text = p_title
			var prog = ProgressBar.new()
			prog.set("max_value",p_all_progress)
			$TvInfo.add_child(title)
			for index in range(p_all_progress):
				var check = CheckBox.new()
				check.connect("toggled",self,"_on_single_check_toggled")
				check.text = str(index)
				check.pressed = checkbox_states.has(str(index)) && checkbox_states[str(index)]
				$TvInfo.add_child(check)
			
func _on_single_check_toogled(p_toggled):
	var check = p_toggled.get_node(".")
	if check:
		var index = check.text
		checkbox_states[str(index)] = check.pressed

func save():
	var data = {
		"checkbox_states": checkbox_states
	}
	var data_file = File.new()
	data_file.open("user://data.json",File.WRITE)
	data_file.store_string(to_json(data))
	data_file.close()
	pass
