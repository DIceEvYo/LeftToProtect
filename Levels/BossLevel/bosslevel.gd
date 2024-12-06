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
	jasmine.intro = true
	var jasmine1 = jasmine_scene.instantiate()
	#ghost.player = player
	jasmine1.position.x = 850
	jasmine1.position.y = 350
	jasmine1.intro = true
	jasmine1.speed = -2
	add_child(jasmine)
	add_child(jasmine1)
	$BackgroundMusic.play()
	await wait_for_timer(32)
	remove_child(jasmine)
	remove_child(jasmine1)
	var jasmine2 = jasmine_scene.instantiate()
	#ghost.player = player
	jasmine2.position.x = 850
	jasmine2.position.y = 350
	jasmine2.intro = false
	add_child(jasmine2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func wait_for_timer(duration):
	$WaitTimer.start(duration)  #Start the timer with the specified duration
	await $WaitTimer.timeout    #Wait until the timeout signal is emitted
