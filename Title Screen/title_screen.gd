extends Control

var bg_scene = preload("res://Background/Scenes/revolving_bg.tscn")

func _on_start_button_pressed():	
	await get_tree().change_scene_to_file("res://Levels/LevelManager/LevelManager.tscn")
	

func _ready():
	Score.lang = "en"
	Score.score = 0
	Score.minilvl = 0 
	$TitleImage.texture = load("res://Title Screen/Title Image.png")
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
	Score.minilvl = 1
	await get_tree().change_scene_to_file("res://Levels/GhostLevel/ghost_level.tscn")

func _on_maid_pressed():
	Score.minilvl = 2
	await get_tree().change_scene_to_file("res://Maid/Scenes/maid_level.tscn")

func _on_boss_pressed():
	Score.minilvl = 3
	await get_tree().change_scene_to_file("res://Levels/BossLevel/bosslevel.tscn")


func _on_option_button_2_item_selected(index):
	if index == 1: 
		Score.lang = "jp"
		$TitleImage.texture = load("res://Title Screen/Title ImageJP.png")
		$CanvasLayer/StartButton.text = "ストーリー"
		$CanvasLayer/Ghost.text = "幽霊"
		$CanvasLayer/Maid.text = "メード"
		$CanvasLayer/Boss.text = "ボス"
		$CanvasLayer/OptionButton.set_item_text(0, "めっちゃ簡単 (500 HP)")
		$CanvasLayer/OptionButton.set_item_text(1, "簡単 (300 HP)")
		$CanvasLayer/OptionButton.set_item_text(2, "ノーマル (250 HP)")
		$CanvasLayer/OptionButton.set_item_text(3, "難しい (150 HP)")
		$CanvasLayer/OptionButton.set_item_text(4, "やべえ (70 HP)")
		$CanvasLayer/OptionButton.set_item_text(5, "ハードコア (10 HP)")
	else:
		Score.lang = "en"
		$TitleImage.texture = load("res://Title Screen/Title Image.png")
		$CanvasLayer/StartButton.text = "Story Mode"
		$CanvasLayer/Ghost.text = "Ghost"
		$CanvasLayer/Maid.text = "Maid"
		$CanvasLayer/Boss.text = "Boss"
		$CanvasLayer/OptionButton.set_item_text(0, "Very Easy (500 HP)")
		$CanvasLayer/OptionButton.set_item_text(1, "Easy (300 HP)")
		$CanvasLayer/OptionButton.set_item_text(2, "Normal (250 HP)")
		$CanvasLayer/OptionButton.set_item_text(3, "Difficult (150 HP)")
		$CanvasLayer/OptionButton.set_item_text(4, "Insane (70 HP)")
		$CanvasLayer/OptionButton.set_item_text(5, "Hardcore (10 HP)")
