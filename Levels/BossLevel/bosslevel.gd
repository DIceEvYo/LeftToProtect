extends Node2D

var player_scene = preload("res://Player/player.tscn")
var jasmine_scene = load("res://JasmineCha/Scenes/jasmine.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = player_scene.instantiate()
	player.position.x = 1030
	player.position.y = 970
	add_child(player)
	var jasmine = jasmine_scene.instantiate()
	#ghost.player = player
	jasmine.position.x = 850
	jasmine.position.y = 350
	add_child(jasmine)
	$BackgroundMusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
