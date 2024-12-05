extends Node2D

var player_scene = preload("res://Player/player.tscn")
var ghost_scene = load("res://Ghost/Scenes/ghost.tscn")
var dialog_scene = preload("res://Ghost/Scenes/DialogSystem.tscn")

func _ready():
	"""
	var dialog = dialog_scene.instantiate()
	add_child(dialog)
	await dialog.tree_exited
	"""
	var player = player_scene.instantiate()
	player.position.x = 960
	player.position.y = 800
	add_child(player)
	var ghost = ghost_scene.instantiate()
	ghost.player = player
	ghost.position.x = 960
	ghost.position.y = 111
	add_child(ghost)
	await wait_for_timer(.5)
	$BackgroundMusic.play()
	

func _process(delta):
	pass

func attack_sequence():
	#Dialogue stuff
	
	#$AnimationPlayer.play("fade_in")
	await wait_for_timer(3.0)
	#$AnimationPlayer.play("fade_out")
	await wait_for_timer(1.0)
	await wait_for_timer(0.34)
	$DialogueBG.stop()
	#First attack
	$BackgroundMusic.play()
	
func wait_for_timer(duration):
	$WaitTimer.start(duration)  #Start the timer with the specified duration
	await $WaitTimer.timeout    #Wait until the timeout signal is emitted
		
