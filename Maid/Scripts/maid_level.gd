extends Node2D

var player_scene = preload("res://Player/player.tscn")
var revolving_background_scene = preload("res://Background/Scenes/revolving_bg.tscn")
var maid_scene = preload("res://Maid/Scenes/Maid.tscn")
var dialog_scene = preload("res://Maid/Scenes/MaidLevelDialogue.tscn")
var game_over = preload("res://Levels/rip/game_over.tscn")
var god = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dialog = dialog_scene.instantiate()
	add_child(dialog)
	await dialog.tree_exited
	
	var score_disp = preload("res://score_label.tscn")
	var score_disp_i = score_disp.instantiate()
	add_child(score_disp_i)
	
	var player = player_scene.instantiate()
	player.position.x = 960
	player.position.y = 800
	var maid = maid_scene.instantiate()
	maid.position.x = 960
	maid.position.y = 150
	maid.player = player
	var revolving_bg = revolving_background_scene.instantiate()
	revolving_bg.limit = 15
	add_child(revolving_bg)
	add_child(player)
	add_child(maid)
	god = true
	$BackgroundMusic.play()
	await $BackgroundMusic.finished
	god = false
	Score.score += player.health
	remove_child(score_disp_i)
	if Score.minilvl > 0:
		await get_tree().change_scene_to_file("res://Levels/final.tscn")
	else:
		queue_free()

func _process(delta):
	if(god):
		_on_player_death()

func _on_player_death():
	if(get_node("Player") == null):
		get_tree().change_scene_to_file.bind("res://Levels/rip/game_over.tscn").call_deferred()
