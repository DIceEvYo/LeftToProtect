extends Node2D

var player_scene = preload("res://Player/player.tscn")
var revolving_background_scene = preload("res://Background/Scenes/revolving_bg.tscn")
var maid_scene = preload("res://Maid/Scenes/Maid.tscn")
var dialog_scene = preload("res://Maid/Scenes/MaidLevelDialogue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dialog = dialog_scene.instantiate()
	add_child(dialog)
	await dialog.tree_exited
	
	var player = player_scene.instantiate()
	player.position.x = 960
	player.position.y = 800
	var maid = maid_scene.instantiate()
	maid.position.x = 960
	maid.position.y = 150
	maid.player = player
	var revolving_bg = revolving_background_scene.instantiate()
	revolving_bg.limit = 10
	add_child(revolving_bg)
	add_child(player)
	add_child(maid)
	$BackgroundMusic.play()
	await $BackgroundMusic.stop()
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
