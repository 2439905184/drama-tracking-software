extends Control

onready var font = load("res://20otf.tres")

var current_title
var current_progress
var current_all_progress

func _ready():
	pass

# 用于手动添加信息
func sync_info(p_title,p_all_progress):
	current_title = p_title
	current_all_progress = p_all_progress
	
	var side_btn = Button.new()
	side_btn.name = p_title
	side_btn.text = p_title
	side_btn.set("custom_fonts/font",font)
	side_btn.connect("pressed",$TvInfo,"_on_show",[p_title,p_all_progress])
	side_btn.connect("pressed",self,"_change_current_title_key",[p_title])
	$side/VBoxContainer.add_child(side_btn)

func _change_current_title_key(p_val):
	current_title = p_val
	print(current_title)
# 用于读取存档后动态添加按钮
func add_side_btn(p_key):
	current_title = p_key
	var side_btn = Button.new()
	side_btn.name = p_key
	side_btn.text = p_key
	side_btn.set("custom_fonts/font",font)
	var c_current_progress = Global.data[p_key].cur_progress
	var c_current_all_progress = Global.data[p_key].all_progress
	side_btn.connect("pressed",$TvInfo,"_on_show2",[p_key,c_current_progress,c_current_all_progress])
	side_btn.connect("pressed",self,"_change_current_title_key",[p_key])
	$side/VBoxContainer.add_child(side_btn)
	
func _on_save_pressed():
	Global.data[""+ current_title +""]={"cur_progress":current_progress,"all_progress":current_all_progress}
	var data_file = File.new()
	data_file.open("user://data.json",File.WRITE_READ)
	data_file.store_string(to_json(Global.data))
	data_file.close()
	pass

func _on_remove_pressed():
	var root = get_node("side/VBoxContainer")
	root.get_node(current_title).queue_free()

	Global.data.erase(current_title)
	var data_file = File.new()
	data_file.open("user://data.json",File.WRITE_READ)
	data_file.store_string(to_json(Global.data))
	data_file.close()
	$TvInfo.hide()

	pass
	
func _on_watched_text_changed(new_text):
	current_progress = int(new_text)
	pass


