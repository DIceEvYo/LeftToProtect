extends Node2D

var player_scene = preload("res://Player/player.tscn")
var jasmine_scene = load("res://JasmineCha/Scenes/jasmine.tscn")
var dialog_scene = load("res://JasmineCha/Scenes/boss_dialog.tscn")
var game_over = preload("res://Levels/rip/game_over.tscn")
var god = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Score.score = 0
	Score.lvl = 3
	var dialog = dialog_scene.instantiate()
	add_child(dialog)
	await dialog.tree_exited
	
	var score_disp = preload("res://score_label.tscn")
	var score_disp_i = score_disp.instantiate()
	add_child(score_disp_i)
	
	var player = player_scene.instantiate()
	player.position.x = 1030
	player.position.y = 970
	add_child(player)
	var jasmine = jasmine_scene.instantiate()
	jasmine.position.x = 850
	jasmine.position.y = 350
	jasmine.intro = true
	jasmine.player = player
	var jasmine1 = jasmine_scene.instantiate()
	jasmine1.position.x = 850
	jasmine1.position.y = 350
	jasmine1.intro = true
	jasmine1.speed = -2
	add_child(jasmine)
	add_child(jasmine1)
	god = true
	$BackgroundMusic.play()
	await wait_for_timer(32)
	remove_child(jasmine)
	remove_child(jasmine1)
	var jasmine2 = jasmine_scene.instantiate()
	jasmine2.position.x = 850
	jasmine2.position.y = 350
	jasmine2.player = player
	jasmine2.build_up = true
	add_child(jasmine2)
	await wait_for_timer(12)
	var angle = [0,  PI/4,  PI/2,  3*PI/4,  PI, 5*PI/4,  3*PI/2,  7*PI/4,  2*PI]
	for a in angle:
		var jasmine3 = jasmine_scene.instantiate()
		jasmine3.position.x = 960
		jasmine3.position.y = 550
		jasmine3.dir = Vector2(cos(a), sin(a)).normalized()
		jasmine3.player = player
		jasmine3.yabai = true
		add_child(jasmine3)
	await wait_for_timer(23)
	jasmine = jasmine_scene.instantiate()
	jasmine.position.x = 850
	jasmine.position.y = 350
	jasmine.end = true
	jasmine.player = player
	jasmine1 = jasmine_scene.instantiate()
	jasmine1.position.x = 850
	jasmine1.position.y = 350
	jasmine1.end = true
	jasmine1.speed = -2
	add_child(jasmine)
	add_child(jasmine1)
	await wait_for_timer(43)
	remove_child(jasmine)
	remove_child(jasmine1)
	god = false
	Score.score += player.health
	Score.total_score += Score.score
	remove_child(score_disp_i)
	Score.lvl = 0
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

func wait_for_timer(duration):
	$WaitTimer.start(duration)  #Start the timer with the specified duration
	await $WaitTimer.timeout    #Wait until the timeout signal is emitted


func _on_control_restart():
	queue_free()
