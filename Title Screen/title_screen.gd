extends Control

var bg_scene = preload("res://Background/Scenes/revolving_bg.tscn")
var title_image = preload("res://Title Screen/Title Image.png")
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Levels/TutorialLevel/TutorialDialogSystem.tscn")

func _ready(): 
	var revolving_bg = bg_scene.instantiate()
	revolving_bg.limit = 14
	add_child(revolving_bg)
	load("res://Title Screen/Title Image.png")
