extends Node2D


var title_image = preload("res://Title Screen/title_screen.tscn")
var tutorial_scene = preload("res://Levels/TutorialLevel/TutorialDialogSystem.tscn")
var ghost_level_scene = preload("res://Levels/GhostLevel/ghost_level.tscn")
var maid_level_scene = preload("res://Maid/Scenes/maid_level.tscn")
var boss_level_scene = preload("res://Levels/BossLevel/bosslevel.tscn")
var final_scene = preload("res://Levels/final.tscn")

func tut():
	var tutorial = tutorial_scene.instantiate()
	add_child(tutorial)
	await tutorial.tree_exited

func ghost():
	var ghost_level = ghost_level_scene.instantiate()
	add_child(ghost_level)
	await ghost_level.tree_exited
	
func maid():
	var maid_level = maid_level_scene.instantiate()
	add_child(maid_level)
	await maid_level.tree_exited

func boss():
	var boss_level = boss_level_scene.instantiate()
	add_child(boss_level)
	await boss_level.tree_exited

func final():
	var final = final_scene.instantiate()
	add_child(final)
	await final.tree_exited
	
func title():
	var title = title_image.instantiate()
	add_child(title)
	await title.tree_exited

func check():
	if Score.lvl == 1:
		await ghost()
		await check()
	elif Score.lvl == 2:
		await maid()
		await check()
	elif Score.lvl == 3:
		await boss()
		await check()

func _ready(): 
	Score.score = 0
	await tut()
	await ghost()
	await check()
	await maid()
	await check()
	await boss()
	await check()
	await final()
	await title()
