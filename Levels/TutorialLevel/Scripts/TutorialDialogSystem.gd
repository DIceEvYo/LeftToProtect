extends Control

# Signals to check when training.
signal move_entered
signal shoot_entered

var player_ref = preload("res://Player/player.tscn")
var minion = preload("res://Player/BabyGolem.tscn")
var enemy_bullet = preload("res://Maid/Scenes/MaidBullet.tscn")

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


func load_dialog():
	
	dialog_sys = $Dialog
	
	#### Bard section
	## Bard
	#dialog_bard = [
		#"There once was a Golem, unlike any other creature",
		#"Its stature grand, with an almighty feature",
		#"A one-of-a-kind core, where it would store",
		#"A quest so noble, it was rendered immobile.",
		#"Many years later, across the land",
		#"A great tremor was felt by every band",
		#"Of Humans and Animals, and all that are fantastical",
		#"Not one was alive, who missed the spectacle",
		#"Such was life, a grandeur festival",
		#"Impromptu in manner, yet always sublime",
		#"But deep down, beneath the blue star",
		#"Something ancient began to awaken afar",
		#"Long forgotten, lost to time",
		#"The Golem was long out of its prime.",
		#"Kadunk it went, Kaclank it went",
		#"Struggling to break from the chains of time",
		#"Until at last, it freed itself",
		#"From years of lime, rime, and grime",
		#"The Golem stood, all high and mighty",
		#"Ready to fulfill its only purpose rightly",
		#"Trudging along, it never noticed",
		#"Its very core had been repurposed...",
		#""
	#]
	
	# Golem
	dialog_1 = [
		"...DIRT.",
		"DIRT BE MINE ❤️... ME BIG PASSION 🤪🔥",
		"ME WANNA BE ONE WIT’ DA DIRT 😌🤲😩",
		"ME WANNA TELL DA 🌍😎",
		"DIRT COOL.",
		"DIRT. DIRT. DIRRRT ❤️"
		
		#"ME ❤️ DIRT 😍✨",
		#"DIRT BE MINE ❤️... ME BIG PASSION 🤪🔥",
		#"ME WANNA BE ONE WIT’ DA DIRT 😌🤲😩",
		#"ME WANNA TELL DA 🌍😎,",
		#"HOW MUCH ME 🥰🔥 AND 😭✨ FOR DIRT 😏🌱."
	]
	
	## Golem
	#dialog_2 = [
		#"...",
		#"...but some do not wish to be happy.",
		#"Some prefer to live in perpetual darkness.",
		#"I will NOT stand for this."
	#]
	#
	## Golem Minion
	#dialog_3 = [
		#"*stomp stomp",
	#]
	
	# Golem Minion
	dialog_4 = [
		"Nyeh! You like them dirts aye?",	
		"Then why are ya just sittin there sonny?",
		"There's a whole world out there just waitin to be covered in dirt my boy!",
		"So get outta here! And show em what ya got!"
	]
	
	# Golem
	dialog_5 = [
		"Dirt."
	]
	
	# Golem Minion
	dialog_6 = [
		"What? You forgot how to throw dirt you say-!? How could you even-?",
		"Even monkeys know how to fling their own poo!",
		"Fine! I suppose I shall help you! (You do like dirt after all!)"
	]
	
	# Golem
	dialog_7 = [
		"Dirt.",
	]
	
	########### Training area dialog ###########
	dialog_20 = [
		"First of all, why are ya just standing there huh?",
		"Use WASD to MOVE!"
	]
	
	dialog_21 = [
		"My grandma moves faster than that! How disappointing! Anyway, move that mouse of yours to properly aim! We don’t want to miss anyone afterall!",
		"Now, I know you’ll be lonely on your journey. So I have a suprise for you.",
		"Whenever you tap the spacebar *or click the left mouse button (NERD), YOU CAN USE ME TO ATTACK! Other than that, you also can...",
	]
	
	dialog_22 = [
		"\"[1 Key] A temporary shield that blocks a singular projectile.\"",
		"\"[2 Key] A special projectile that absorbs enemy projectiles, whilst making itself more larger and powerful.\"",
		"\"[3 Key] The ability to spawn a minature combat-oriented golem to aid you in battle.\"",
		"\"Press the respective number on your keyboard to activate each one.\"",
		"\"Beware, these abilities take time to recharge/replenish themselves. Use them wisely, heh as if! \"",
	]	
	
	dialog_23 = [
		"So! Are you ready!? Actually- what am I asking? Of course you are!",
		"Now get out there! We’ve got some dirt to project!"
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialog()
	$Bard.modulate.a = 100
	$"???".modulate.a = 0
	$Golem.modulate.a = 0
	$Golem_Minion.modulate.a = 0
	
	# Golem
	$DialogueBG2.play()
	$Voice.pitch_scale = 1
	var golem1 = player_ref.instantiate()
	add_child(golem1)
	golem1.set_process(false)
	golem1.set_physics_process(false)
	
	golem1.position.x = -400
	golem1.position.y = -400
	golem1.scale.x = 2
	golem1.scale.y = 2
	$Bard.modulate.a = 0
	$"???".modulate.a = 0
	#Golem
	$Golem.modulate.a = 100
	$Voice.pitch_scale = 1
	await read_dialog(dialog_1)
	#Golem Minion
	$Golem.modulate.a = 0
	$Golem_Minion.modulate.a = 100
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
	$Voice.pitch_scale = 3
	$DialogueBG2.stop()
	$DialogueBG.play()
	await read_dialog(dialog_4)
	
	#Golem
	$Voice.pitch_scale = 1
	$Golem_Minion.modulate.a = 0
	$Golem.modulate.a = 100
	await read_dialog(dialog_5)
	
	#Golem Minion
	$Voice.pitch_scale = 3
	$Golem.modulate.a = 0
	$Golem_Minion.modulate.a = 100
	await read_dialog(dialog_6)
	
	#Golem
	$Voice.pitch_scale = 1
	$Golem_Minion.modulate.a = 0
	$Golem.modulate.a = 100
	await read_dialog(dialog_7)
	
	#$Transition_Time.start()
	#await $Transition_Time.timeout
	$DialogueBG.stop()
	
	############## Training Area ###############
	$DialogueBG3.play()
	$Voice.pitch_scale = 3
	$Golem.modulate.a = 0
	$Golem_Minion.modulate.a = 100
	
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
	
	$Golem_Minion.modulate.a = 0
	golem1.set_process(true)
	golem1.set_physics_process(true)
	
	await move_entered
	#$Transition_Time.start()
	#await $Transition_Time.timeout
	golem1.set_process(false)
	golem1.set_physics_process(false)
	
	$Golem_Minion.modulate.a = 100
	
	await read_dialog(dialog_21)
	
	#$Golem_Minion.modulate.a = 0
	golem1.set_process(true)
	golem1.set_physics_process(true)
	
	#await shoot_entered
	$Golem_Minion.modulate.a = 100
	
	await read_dialog2(dialog_22)
	
#	$Golem_Minion.modulate.a = 0
	#$Transition_Time.start()
	#await $Transition_Time.timeout
	$Golem_Minion.modulate.a = 100
	
	await read_dialog(dialog_23)
	
	#$Transition_Time.start()
	#await $Transition_Time.timeout
	while ($Dialog.modulate.a>0):
		$Dialog.modulate.a -= 0.05
		$Golem_Minion.modulate.a -= 0.05
		$Timer.start(.01)
		await $Timer.timeout
	$Golem_Minion.modulate.a = 0
	$DialogueBG3.stop()
	queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event.is_action_pressed("up") or event.is_action_pressed("down") or event.is_action_pressed("left") or event.is_action_pressed("right"):
		move_entered.emit()
		
	if event.is_action_pressed("shoot"):
		shoot_entered.emit()
		
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
		$Timer.start(.035)
		await $Timer.timeout
		dialog_sys.add_text(c)	
		
func read_dialog2(dialog):
	for line in dialog:
		dialog_sys.clear()
		await speech2(line)
		$Timer.start(.75)
		await $Timer.timeout
		dialog_sys.clear()

func speech2(text):
	for c in text:
		$Voice.play()
		$Timer.start(.005)
		await $Timer.timeout
		dialog_sys.add_text(c)	


func _on_skip_button_pressed():
	queue_free()
