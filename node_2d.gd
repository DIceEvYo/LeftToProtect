extends Node2D

var bg_scene = preload("res://Background/Scenes/revolving_bg.tscn")
var title_image = preload("res://Title Screen/Title Image.png")
#var tutorial_scene = preload("res://Levels/TutorialLevel/TutorialDialogSystem.tscn")
#var ghost_level_scene = preload("res://Levels/GhostLevel/ghost_level.tscn")
#var maid_level_scene = preload("res://Levels/GhostLevel/ghost_level.tscn")
var boss_level_scene = preload("res://Levels/BossLevel/bosslevel.tscn")


func _ready(): 
	#var tutorial = tutorial_scene.instantiate()
	#add_child(tutorial)
	#await tutorial.tree_exited
	#var ghost_level = ghost_level_scene.instantiate()
	#add_child(ghost_level)
	#await ghost_level.tree_exited
	#var maid_level = maid_level_scene.instantiate()
	#add_child(maid_level)
	#await maid_level.tree_exited
	var boss_level = boss_level_scene.instantiate()
	add_child(boss_level)
	await boss_level.tree_exited
