extends VBoxContainer


func _ready():
	pass

func _on_show(p_title,p_all_progress):
	self.show()
	$Title.text = p_title
	$all.text = p_all_progress
	$ProgressBar.set("max_value",int(p_all_progress))
	
func _on_show2(p_title,p_cur_progress,p_all_progress):
	self.show()
	$Title.text = p_title
	$watched.text = str(p_cur_progress)
	$all.text = p_all_progress
	$ProgressBar.set("value",int(p_cur_progress))
	$ProgressBar.set("max_value",int(p_all_progress))
	
func _on_all_text_changed(new_text):
	$ProgressBar.set("max_value",int(new_text))
	pass


func _on_watched_text_changed(new_text):
	$ProgressBar.set("value",int(new_text))
	pass 
