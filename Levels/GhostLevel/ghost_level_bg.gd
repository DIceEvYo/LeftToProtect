extends Node2D

var player_scene = preload("res://Player/player.tscn")
var ghost_scene = load("res://Ghost/Scenes/ghost.tscn")
var dialog_scene = preload("res://Ghost/Scenes/DialogSystem.tscn")
var revolving_bg_scene = preload("res://Background/Scenes/revolving_bg.tscn")
var game_over = preload("res://Levels/rip/game_over.tscn")
var god = false

func _ready(): 
	Score.score = 0
	var dialog = dialog_scene.instantiate()
	add_child(dialog)
	await dialog.tree_exited
	
	var score_disp = preload("res://score_label.tscn")
	var score_disp_i = score_disp.instantiate()
	add_child(score_disp_i)
	
	var revolving_bg = revolving_bg_scene.instantiate()
	revolving_bg.limit = 14
	add_child(revolving_bg)
	var player = player_scene.instantiate()
	player.position.x = 960
	player.position.y = 800
	var ghost = ghost_scene.instantiate()
	ghost.player = player
	ghost.position.x = 970
	ghost.position.y = 111
	await wait_for_timer(1)
	add_child(ghost)
	add_child(player)
	god = true
	$BackgroundMusic.play()
	await $BackgroundMusic.finished
	god = false
	ghost.modulate.a -= 1
	player.modulate.a -= 1
	await wait_for_timer(2)
	remove_child(ghost)
	Score.score += player.health
	remove_child(player)
	remove_child(score_disp_i)
	Score.total_score += Score.score
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
		
