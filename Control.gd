extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true

func _on_language_item_selected(index):
	if index == 1: 
		Score.lang = "jp"
	else:
		Score.lang = "en"


func _on_continue_pressed():
	get_tree().paused = false
	queue_free()


func _on_retry_pressed():
	get_tree().paused = true
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().paused = true
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().paused = true
	get_tree().change_scene_to_file("res://Title Screen/title_screen.tscn")
