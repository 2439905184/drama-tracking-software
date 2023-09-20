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
	side_btn.text = p_title
	side_btn.set("custom_fonts/font",font)
	side_btn.connect("pressed",$TvInfo,"_on_show",[p_title,p_all_progress])
	$side/VBoxContainer.add_child(side_btn)

# 用于读取存档后动态添加按钮
func add_side_btn(p_key):
	current_title = p_key
	var side_btn = Button.new()
	side_btn.text = p_key
	side_btn.set("custom_fonts/font",font)
	var c_current_progress = Global.data[p_key].cur_progress
	var c_current_all_progress = Global.data[p_key].all_progress
	side_btn.connect("pressed",$TvInfo,"_on_show2",[p_key,c_current_progress,c_current_all_progress])
	$side/VBoxContainer.add_child(side_btn)
	
func _on_save_pressed():
	Global.data[""+ current_title +""]={"cur_progress":current_progress,"all_progress":current_all_progress}
	var data_file = File.new()
	data_file.open("user://data.json",File.WRITE_READ)
	data_file.store_string(to_json(Global.data))
	data_file.close()
	pass

func _on_remove_pressed():
	Global.data.erase(current_title)
	var data_file = File.new()
	data_file.open("user://data.json",File.WRITE_READ)
	data_file.store_string(to_json(Global.data))
	data_file.close()
	$TvInfo.hide()
#	删除暂时未实现
#	var to_del_node = get_tree().current_scene.get_node("View/side/VBoxContainer/"+current_title)
#	print(to_del_node)
#	var root = get_node("side/VBoxContainer")
#	var c = root.get_child(0)
#	var txt = c.get("text")
#	print(txt)
#	print(current_title)
#	if current_title == txt:
#		print("ok")
#	else:
#		print("string has bug")
#	print(root.get_node(current_title))
	pass
	
func _on_watched_text_changed(new_text):
	current_progress = int(new_text)
	pass


