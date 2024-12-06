extends Control

var player_ref = preload("res://Player/player.tscn")
var minion = preload("res://Player/BabyGolem.tscn")
var enemy_bullet = preload("res://Maid/MaidBullet.tscn")

var facial_expression

var dialog_sys

# Prologue
var dialog_bard

# Intro
var dialog_1
var dialog_2
var dialog_3
var dialog_4
var dialog_5
var dialog_6
var dialog_7
var dialog_8

# Training
var dialog_20
var dialog_21
var dialog_22
var dialog_23
var dialog_24
var dialog_25
var dialog_26
var dialog_27
var dialog_28
var dialog_29


func load_dialog():
	
	dialog_sys = $Dialog
	
	### Bard section
	# Bard
	dialog_bard = [
		"There once was a Golem, unlike any other creature",
		"Its stature grand, with an almighty feature",
		"A one-of-a-kind core, where it would store",
		"A quest so noble, it was rendered immobile.",
		"Many years later, across the land",
		"A great tremor was felt by every band",
		"Of Humans and Animals, and all that are fantastical",
		"Not one was alive, who missed the spectacle",
		"Such was life, a grandeur festival",
		"Impromptu in manner, yet always sublime",
		"But deep down, beneath the blue star",
		"Something ancient began to awaken afar",
		"Long forgotten, lost to time",
		"The Golem was long out of its prime.",
		"Kadunk it went, Kaclank it went",
		"Struggling to break from the chains of time",
		"Until at last, it freed itself",
		"From years of lime, rime, and grime",
		"The Golem stood, all high and mighty",
		"Ready to fulfill its only purpose rightly",
		"Trudging along, it never noticed",
		"Its very core had been repurposed...",
		""
	]
	
	# Golem
	dialog_1 = [
		"...DIRT.",
		"...DIRT...LOVE.",
		"DIRT BE MY LOVE, MY BIG PASSION.",
		"SHARE DIRT LOVE.",
		"WORLD MUST KNOW. DIRT COOL.",
		"SHOW WORLD DIRT PASSION."
		
		#"ME ❤️ DIRT 😍✨",
		#"DIRT BE MINE ❤️... ME BIG PASSION 🤪🔥",
		#"ME WANNA BE ONE WIT’ DA DIRT 😌🤲😩",
		#"ME WANNA TELL DA 🌍😎,",
		#"HOW MUCH ME 🥰🔥 AND 😭✨ FOR DIRT 😏🌱."
	]
	
	# Golem
	dialog_2 = [
		"...",
		"...but some do not wish to be happy.",
		"Some prefer to live in perpetual darkness.",
		"I will NOT stand for this."
	]
	
	# Golem Minion
	dialog_3 = [
		"*stomp stomp",
	]
	
	# Golem Minion
	dialog_4 = [
		"Why, if it isn't my mighty \"Lord\"! How've you been, tough guy?",	
		"Are those gears treating you right, you relic? Need some oil?"
	]
	
	# Golem
	dialog_5 = [
		"...dirt."
	]
	
	# Golem Minion
	dialog_6 = [
		"...wat"
	]
	
	# Golem
	dialog_7 = [
		"dirt"
	]
	
	# Golem Minion
	dialog_8 = [
		"The heck is wrong with you? I knew you already had a loose screw, but not THAT many.",
		"Don't tell me your core's been damaged again, you mindless, braindead hunk of metal.",
		"*sigh. Looks like it's back to square one. Alright, follow me out, metalbrain. It's time for some training..."
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialog()
	$Bard.modulate.a = 100
	$"???".modulate.a = 0
	$Golem.modulate.a = 0
	$Golem_Minion.modulate.a = 0
	
	
	#facial_expression = load("res://Ghost/幽霊イラスト/寝ている/怠け者.png")
	#$GhostIllust.texture = facial_expression
	#$AnimationPlayer.play("fade_in")
	#$DialogueBG.play()
	
	# Intro bard
	#await read_dialog(dialog_bard)
	
	
	# Golem
	var golem1 = player_ref.instantiate()
	add_child(golem1)
	golem1.set_process(false)
	golem1.set_physics_process(false)
	
	golem1.position.x = -400
	golem1.position.y = -400
	golem1.scale.x = 2
	golem1.scale.y = 2
	$Bard.modulate.a = 0
	$"???".modulate.a = 100
	#await read_dialog(dialog_1)
	
	
	# Golem
	#await read_dialog(dialog_2)
	
	
	# Golem Minion
	$"???".modulate.a = 0
	#await read_dialog(dialog_3)
	
	
	# Golem Minion
	var minion1 = minion.instantiate()
	add_child(minion1)
	
	minion1.position.x = 400
	minion1.position.y = -400
	var children = minion1.get_children()
	children[3].paused = true
	for i in range(2):
		var target = children[i]
		target.scale.x = 3
		target.scale.y = 3
		
	$Golem_Minion.modulate.a = 100
	$DialogueBG.play()
	await read_dialog(dialog_4)
	
	
	# Golem
	$Golem_Minion.modulate.a = 0
	$Golem.modulate.a = 100
	await read_dialog(dialog_5)
	
	
	# Golem Minion
	$Golem.modulate.a = 0
	$Golem_Minion.modulate.a = 100
	await read_dialog(dialog_6)
	
	
	# Golem
	$Golem_Minion.modulate.a = 0
	$Golem.modulate.a = 100
	await read_dialog(dialog_7)	
	
	
	# Golem Minion
	$Golem.modulate.a = 0
	$Golem_Minion.modulate.a = 100
	await read_dialog(dialog_8)	
	$Golem_Minion.modulate.a = 0
	
	$Transition_Time.start()
	await $Transition_Time.timeout
	$DialogueBG.stop()
	
	############## Training Area ###############
	$Golem_Minion.modulate.a = 100
	
	golem1.set_process(true)
	golem1.set_physics_process(true)
	
	# Change positions and scale of both Golem and Golem Minion.
	golem1.position.x = 0
	golem1.position.y = -400
	golem1.scale.x = 1
	golem1.scale.y = 1
	
	minion1.position.x = 0
	minion1.position.y = -800
	for i in range(2):
		var target = children[i]
		target.scale.x = 1
		target.scale.y = 1
		
		
	#### Dialogue
	# Golem Minion
	await read_dialog(dialog_20)
	
	#$AnimationPlayer.play("fade_out")
	#await $AnimationPlayer.animation_finished
	#while ($Dialog_Box.modulate.a>0):
		#$Dialog_Box.modulate.a -= 0.05
		#$Name_en.modulate.a -= 0.05
		#$Name_jp.modulate.a -= 0.05
		#$Timer.start(.01)
		#await $Timer.timeout
	#queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func read_dialog(dialog):
	for line in dialog:
		dialog_sys.clear()
		await speech(line)
		$Timer.start(1)
		await $Timer.timeout
		dialog_sys.clear()

func speech(text):
	for c in text:
		$Voice.play()
		$Timer.start(.075)
		await $Timer.timeout
		dialog_sys.add_text(c)	
