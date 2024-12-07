extends Control

var bg_scene = preload("res://Background/Scenes/revolving_bg.tscn")
var title_image = preload("res://Title Screen/Title Image.png")
var tutorial_scene = preload("res://Levels/TutorialLevel/TutorialDialogSystem.tscn")
var ghost_level_scene = preload("res://Levels/GhostLevel/ghost_level.tscn")
var maid_level_scene = preload("res://Levels/GhostLevel/ghost_level.tscn")
var boss_level_scene = preload("res://Levels/GhostLevel/ghost_level.tscn")
func _on_start_button_pressed():	
	var tutorial = tutorial_scene.instantiate()
	get_tree().change_scene_to_file("res://Levels/TutorialLevel/TutorialDialogSystem.tscn")
	add_child(tutorial)
	await tutorial.tree_exited
	var ghost_level = ghost_level_scene.instantiate()
	add_child(ghost_level)
	await ghost_level.tree_exited
	var maid_level = maid_level_scene.instantiate()
	add_child(maid_level)
	await maid_level.tree_exited
	var boss_level = boss_level_scene.instantiate()
	add_child(boss_level)
	await boss_level.tree_exited
	

func _ready(): 
	var revolving_bg = bg_scene.instantiate()
	revolving_bg.limit = 14
	add_child(revolving_bg)
	load("res://Title Screen/Title Image.png")
