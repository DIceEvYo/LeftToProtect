extends Control

var bg_scene = preload("res://Background/Scenes/revolving_bg.tscn")
var title_image = preload("res://Title Screen/Title Image.png")


func _on_start_button_pressed():	
	await get_tree().change_scene_to_file("res://Levels/LevelManager/LevelManager.tscn")
	queue_free()
	

func _ready(): 
	load("res://Title Screen/Title Image.png")
	var revolving_bg = bg_scene.instantiate()
	revolving_bg.limit = 300
	add_child(revolving_bg)
