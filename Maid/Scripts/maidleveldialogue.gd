extends Control

var maid_facial_expression
var ghost_facial_expression
var golem

var dialogue_sys
var dia_1
var dia_2
var dia_3
var dia_4
var dia_5
var dia_6
var dia_7
var dia_8
var dia_9
var dia_10
var dia_11
var dia_12
var dia_13
var dia_14

func load_dialogue():
	dialogue_sys = $Dialogue
	dia_1 = [
		"So... gross..."
	]
	dia_2 = [
		"Oiii! What's with all this commotion!"
	]
	dia_3 = [
		"GOLEM-KYUN WHY ARE YOU THROWING DIRT EVERYWHERE??"
	]
	dia_4 = [
		"Dirt."
	]
	dia_5 = [
		"Wait-! You know this weirdo!?"
	]
	dia_6 = [
		"A-Ahh... Umm... (Oh no, I slipped!! What should I do??)"
	]
	dia_7 = [
		"N-NOT AT ALL! OF COURSE NOT! HAHAHA! (Sorry Golem-kyun..!)"
	]
	dia_8 = [
		"GOLEM.. GOLEM-KUN!"
	]
	dia_9 = [
		"AS A CERTIFIED MAID, I CAN'T ALLOW THIS BEHAVIOR TO CONTINUE!"
	]
	dia_10 = [
		"Certified by who?"
	]
	dia_11 = [
		"SHADDAP!!"
	]
	dia_12 = [
		"Dirt."
	]
	dia_13 = [
		"PREPARE TO MEET YOUR MOE MOE DOOM!"
	]
	dia_14 = [
		"Dirt."
	]
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DialogueBGM.play()
	$MaidIllust.modulate.a = 0
	$MaidName.modulate.a = 0
	$GhostName.modulate.a = 100
	$GhostIllust.position.x = 0
	$GolemName.modulate.a = 0
	load_dialogue()
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_default.png")
	ghost_facial_expression = load("res://Ghost/Illustrations/angry/pissed.png")
	#golem = load("res)
	$GhostIllust.texture = ghost_facial_expression
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_1)
	$GhostIllust.position.x = 300
	$MaidIllust.modulate.a = 100
	$MaidName.modulate.a = 100
	$GhostName.modulate.a = 0
	await read_dialogue(dia_2)
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_dx.png")
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_3)
	$MaidName.modulate.a = 0
	$GhostName.modulate.a = 0
	$GolemName.modulate.a = 100
	await read_dialogue(dia_4)
	$GhostName.modulate.a = 100
	$GolemName.modulate.a = 0
	ghost_facial_expression = load("res://Ghost/Illustrations/hmmm？/what are you saying.png")
	$GhostIllust.texture = ghost_facial_expression
	await read_dialogue(dia_5)
	$MaidName.modulate.a = 100
	$GhostName.modulate.a = 0
	ghost_facial_expression = load("res://Ghost/Illustrations/angry/pissed.png")
	$GhostIllust.texture = ghost_facial_expression
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_nervous.png")
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_6)
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_smug.png")
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_7)
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_dx.png")
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_8)
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_default.png")
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_9)
	$MaidName.modulate.a = 0
	$GhostName.modulate.a = 100
	ghost_facial_expression = load("res://Ghost/Illustrations/smile/smug1.png")
	$GhostIllust.texture = ghost_facial_expression
	await read_dialogue(dia_10)
	$MaidName.modulate.a = 100
	$GhostName.modulate.a = 0
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_dx.png")
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_11)
	$MaidName.modulate.a = 0
	$GhostName.modulate.a = 0
	$GolemName.modulate.a = 100
	await read_dialogue(dia_12)
	$MaidName.modulate.a = 100
	$GolemName.modulate.a = 0
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_smug.png")
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_13)
	$MaidName.modulate.a = 0
	$GolemName.modulate.a = 100
	await read_dialogue(dia_14)
	$GolemName.modulate.a = 0
	queue_free()
	
	
	
	
	
	pass # Replace with function body.

func read_dialogue(dialogue):
	for line in dialogue:
		dialogue_sys.clear()
		await speech(line)
		$Timer.start(1.5)
		await $Timer.timeout
		dialogue_sys.clear()

func speech(text):
	for c in text:
		$Voice.play()
		$Timer.start(.075)
		await $Timer.timeout
		dialogue_sys.add_text(c)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
