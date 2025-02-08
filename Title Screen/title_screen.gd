extends Control

var bg_scene = preload("res://Background/Scenes/revolving_bg.tscn")
var title_image = preload("res://Title Screen/Title Image.png")


func _on_start_button_pressed():	
	await get_tree().change_scene_to_file("res://Levels/LevelManager/LevelManager.tscn")
	

func _ready(): 
	load("res://Title Screen/Title Image.png")
	var revolving_bg = bg_scene.instantiate()
	revolving_bg.limit = 300
	add_child(revolving_bg)


func _on_option_button_item_selected(index):
	if index == 5:
		Score.hp = 10
	elif index == 4:
		Score.hp = 70
	elif index == 3:
		Score.hp = 150
	elif index == 2:
		Score.hp = 250
	elif index == 1:
		Score.hp = 300
	else:
		Score.hp = 500


func _on_ghost_pressed():
	await get_tree().change_scene_to_file("res://Levels/GhostLevel/ghost_level.tscn")

func _on_maid_pressed():
	await get_tree().change_scene_to_file("res://Maid/Scenes/maid_level.tscn")

func _on_boss_pressed():
	await get_tree().change_scene_to_file("res://Levels/BossLevel/bosslevel.tscn")


func _on_option_button_2_item_selected(index):
	if index == 1: 
		Score.lang = "jp"
		$CanvasLayer/StartButton.text = "ストーリー"
		$CanvasLayer/Ghost.text = "幽霊"
		$CanvasLayer/Maid.text = "メード"
		$CanvasLayer/Boss.text = "ボス"
	else:
		Score.lang = "en"
		$CanvasLayer/StartButton.text = "Story Mode"
		$CanvasLayer/Ghost.text = "Ghost"
		$CanvasLayer/Maid.text = "Maid"
		$CanvasLayer/Boss.text = "Boss"
