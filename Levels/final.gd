extends Control

var voice

var jas_facial_expression

var dialogue_sys
var dia_0
var dia_1
var dia_2

func load_dialogue():
	dialogue_sys = $Dialogue
	dia_0 = [
		"Well, that was refreshing!"
	]
	dia_1 = [
		"Thanks for playing!"
	]
	dia_2 = [
		"Final Score: " + str(Score.score)
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialogue()
	$Jasmine.modulate.a = 100
	
	$Jasmine2.modulate.a = 100

	voice = $JasmineVoice
	await read_dialogue(dia_0)
	await read_dialogue(dia_1)
	$Jasmine.modulate.a = 0
	$GolemVoice.pitch_scale = 3
	voice = $GolemVoice
	await read_dialogue(dia_2)
	queue_free()


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
