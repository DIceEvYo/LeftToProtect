extends Control

var voice

var dialogue_sys
var dia_0
var dia_1

var player_ref = preload("res://Player/player.tscn")
var minion = preload("res://Player/BabyGolem.tscn")

func load_dialogue():
	dialogue_sys = $Dialogue
	dia_0 = [
		"My my sonny, it appears you got a skill issue",
		"How disappointing.",
		"Get good."
	]
	dia_1 = [
		"Dirt."
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialogue()
	var minion1 = minion.instantiate()
	minion1.position.x = 916
	minion1.position.y = 100
	add_child(minion1)
	$GolemName.modulate.a = 0
	$GolemMinion.modulate.a = 0
	

	#GOLEM MINION
	$GolemMinion.modulate.a = 100
	$GolemVoice.pitch_scale = 3
	voice = $GolemVoice
	await read_dialogue(dia_0)	
	
	#GOLEM
	$GolemMinion.modulate.a = 0
	$GolemName.modulate.a = 100
	$GolemVoice.pitch_scale = 1
	voice = $GolemVoice
	await read_dialogue(dia_1)
	
	#get_tree().change_scene_to_file("res://Title Screen/title_screen.tscn")
	get_tree().change_scene_to_file.bind("res://Title Screen/title_screen.tscn").call_deferred()
	

func read_dialogue(dialogue):
	for line in dialogue:
		dialogue_sys.clear()
		await speech(line)
		$Timer.start(1.5)
		await $Timer.timeout
		dialogue_sys.clear()

func speech(text):
	for c in text:
		voice.play()
		$Timer.start(.045)
		await $Timer.timeout
		dialogue_sys.add_text(c)

func _on_skip_button_pressed():
	queue_free()
