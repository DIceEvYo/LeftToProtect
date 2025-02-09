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
var dialog_0
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
var dialog_23
var dialog_24
var time


func load_dialog():
	dialog_sys = $Dialog
	if Score.lang == "jp":
		time = 0.065
		$Golem.text = "ゴーレム"
		$Golem_Minion.text = "ゴーレムのミニオン"
		$SkipButton.text = "スキップ"
		dialog_0 = ["「ダイアログを続けるために、ショートカットボタン（左ボタン、スペースバー）を使ってね。」",
		"楽しくプレイしてね～(*^_^*)"]
		dialog_1 = [
			"土。",
			"僕のもの。。。僕の情熱。",
			"土と一つになりたい。",
			"この世界に伝えたい。",
			"土は最高。",
			"土。土。土ぃぃぃぃぃ！！！<3"
		]
		dialog_4 = [
			"ふん？土が好きなのか？",	
			"じゃあ、なぜそこにすわってるのか？",
			"土で覆う世界が待ってるんだぞ！",
			"さあ、出ていけ！お前の力を全部見せろ！"
		]
		dialog_5 = [
			"土。"
		]
		dialog_6 = [
			"なんだと？土を投げるのを忘れたって！？どうやってだよ！？",
			"サルだってウンコを投げるって知ってるぞ！",
			"いいだろう、手伝ってあげる！（土が好きだから。）"
		]
		dialog_7 = [
			"土。",
		]
		dialog_20 = [
			"まず、なんでまだ座ってるんだろう？",
			"WASDで動け！"
		]	
		dialog_21 = [
			"なんだよ！うちの祖母のほうがよっぽど速いぞ！とにかく、マウスでちゃんとターゲットしろ！ミスるんじゃねぇ！",
			"もっと撃てばスコアが上がるんだ！",
			"さあ、この旅は寂しくなるだろう？だからプレゼントをあげる！",
			"攻撃するには、スペースバーか左ボタンを押せ！俺を撃ってみろ！",
		]
		dialog_23 = [
			"じゃあ、準備はいいか？いや、何を聞いてるんだ俺は？当然だろ！",
			"さあ、外へ行け！ダート・トゥ・プロジェクトをやるんだ！"
		]
	else:
		time = 0.045
		$Golem.text = "Golem"
		$Golem_Minion.text = "Golem Minion"
		$SkipButton.text = "Skip"
		dialog_0 = ["[Use the shortcut buttons (Left Click, SpaceBar) to continue through the dialog]",
		"Enjoy the game~ (*^_^*)"]
		dialog_1 = [
			"...DIRT.",
			"DIRT BE MINE... ME BIG PASSION",
			"ME WANNA BE ONE WIT’ DA DIRT",
			"ME WANNA TELL DA WORLD",
			"DIRT COOL.",
			"DIRT. DIRT. DIRRRT <3"
		]
		dialog_4 = [
			"Nyeh! You like them dirts aye?",	
			"Then why are ya just sittin there sonny?",
			"There's a whole world out there just waitin to be covered in dirt my boy!",
			"So get outta here! And show em what ya got!"
		]
		dialog_5 = [
			"Dirt."
		]
		dialog_6 = [
			"What? You forgot how to throw dirt you say-!? How!?",
			"Even monkeys know how to fling their own poo!",
			"Fine! I suppose I shall help you! (You do like dirt after all!)"
		]
		dialog_7 = [
			"Dirt.",
		]
		dialog_20 = [
			"First of all, why are ya just standing there huh?",
			"Use WASD to MOVE!"
		]	
		dialog_21 = [
			"My grandma moves faster than that! Anyway, move that mouse of yours to properly aim! We don’t want to miss anyone after all!",
			"The more people we hit, the higher our score!",
			"Now, I know you’ll be lonely on your journey. So I have a suprise for you.",
			"Whenever you tap the spacebar *or click the left mouse button (NERD), YOU CAN USE ME TO ATTACK!",
		]
		dialog_23 = [
			"So! Are you ready!? Actually- what am I asking? Of course you are!",
			"Now get out there! We’ve got some Dirt to Project!"
		]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialog()
	$Bard.modulate.a = 0
	$"???".modulate.a = 0
	$Golem.modulate.a = 0
	$Golem_Minion.modulate.a = 0
	await read_dialog(dialog_0)
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
	golem1.position.y = -500
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
	#golem1.set_process(true)
	#golem1.set_physics_process(true)
	#golem1.position.x = 0
	#golem1.position.y = -500
	
	await move_entered
	#$Transition_Time.start()
	#await $Transition_Time.timeout
	golem1.set_process(false)
	golem1.set_physics_process(false)
	
	$Golem_Minion.modulate.a = 100
	
	await read_dialog(dialog_21)
	
	#$Golem_Minion.modulate.a = 0
	#golem1.set_process(true)
	#golem1.set_physics_process(true)
	
	#await shoot_entered
	$Golem_Minion.modulate.a = 100
	
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
	

signal continue_dialog
func _input(event):
	if event.is_action_pressed("up") or event.is_action_pressed("down") or event.is_action_pressed("left") or event.is_action_pressed("right"):
		move_entered.emit()
		
	if event.is_action_pressed("shoot"):
		shoot_entered.emit()
		
	if event.is_action_pressed("shoot"):
		continue_dialog.emit()

func read_dialog(dialog):
	for line in dialog:
		dialog_sys.clear()
		await speech(line)
		await continue_dialog
		dialog_sys.clear()

func speech(text):
	for c in text:
		$Voice.play()
		$Timer.start(time)
		await $Timer.timeout
		dialog_sys.add_text(c)		


func _on_skip_button_pressed():
	queue_free()
