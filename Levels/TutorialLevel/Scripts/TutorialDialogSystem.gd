extends Control

var facial_expression
var Golem = "res://Player/Sprites/GolemSprite-0001.png"

var dialog_sys
var dialog_1
var dialog_2
var dialog_3
var dialog_4
var dialog_4_5
var dialog_4_7
var dialog_5
var dialog_5_1
var dialog_5_2
var dialog_6
var dialog_7

func load_dialog():
	
	dialog_sys = $Dialog
	
	# Golem
	dialog_1 = [
		"ME ❤️ DIRT 😍✨",
		"DIRT BE MINE ❤️... ME BIG PASSION 🤪🔥",
		"ME WANNA BE ONE WIT’ DA DIRT 😌🤲😩",
		"ME WANNA TELL DA 🌍😎,",
		"HOW MUCH ME 🥰🔥 AND 😭✨ FOR DIRT 😏🌱."
	]
	
	# None
	dialog_2 = [
		"...",
		"...but some do not wish to be happy.",
		"Some prefer to live in perpetual darkness.",
		"*munch munch",
		"I will not let this stand."
	]
	
	# Golem Minion
	dialog_3 = [
		"*stomp stomp",
	]
	
	#
	dialog_4 = [
		"Oh? To who do I owe the pleaseure to.",	
		""
	]
	dialog_4_5 = [
		"You're kind of weird for that, but NO-!"
	]
	dialog_4_7 = [
		"I was just... Umm..."
	]
	dialog_5 = [
		"I WAS JUST TESTING YOUR ABILITIES! I KNEW YOU WERE HERE THE WHOLE TIME!",
	]
	dialog_5_1 = [
		"NOTHING EVER GETS PASSED ME!",
	]
	dialog_5_2 = [
		"YEAH! THAT'S RIGHT! YOU FELL FOR IT DUMB DUMB!!!",
	]
	dialog_6 = [
		"I totally wasn't sleeping.. or anything-!"
	]
	dialog_7 = [
		"Anyway... What brings a nonhuman to the underrealm?"
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialog()
	# Fades out the japanese one (not used, but need to keep it to opacify it.)
	$Golem_Minion.modulate.a = 0
	
	#facial_expression = load("res://Ghost/幽霊イラスト/寝ている/怠け者.png")
	#$GhostIllust.texture = facial_expression
	#$AnimationPlayer.play("fade_in")
	#$DialogueBG.play()
	
	await read_dialog(dialog_1)
	#facial_expression = load("res://Ghost/幽霊イラスト/へえええ？？/来るな！.png")
	#$GhostIllust.texture = facial_expression
	await read_dialog(dialog_2)
	#facial_expression = load("res://Ghost/幽霊イラスト/へえええ？？/あれれれ？？.png")
	#$GhostIllust.texture = facial_expression
	await read_dialog(dialog_3)
	#facial_expression = load("res://Ghost/幽霊イラスト/悲しい!！/うわっ！.png")
	#$GhostIllust.texture = facial_expression
	await read_dialog(dialog_4)
	#facial_expression = load("res://Ghost/幽霊イラスト/怒っている/頭にくる！.png")
	#$GhostIllust.texture = facial_expression
	await read_dialog(dialog_4_5)
	#facial_expression = load("res://Ghost/幽霊イラスト/ふんん。。。？/なんだ？.png")
	#$GhostIllust.texture = facial_expression
	await read_dialog(dialog_4_7)
	#facial_expression = load("res://Ghost/幽霊イラスト/ニヤニヤ/目を瞑っている.png")
	#$GhostIllust.texture = facial_expression
	await read_dialog(dialog_5)	
	#facial_expression = load("res://Ghost/幽霊イラスト/ニヤニヤ/只管２.png")
	#$GhostIllust.texture = facial_expression
	await read_dialog(dialog_5_1)	
	#facial_expression = load("res://Ghost/幽霊イラスト/ニヤニヤ/只管１.png")
	#$GhostIllust.texture = facial_expression
	await read_dialog(dialog_5_2)	
	#facial_expression = load("res://Ghost/幽霊イラスト/ふん！/仏頂面.png")
	#$GhostIllust.texture = facial_expression
	await read_dialog(dialog_6)
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	while ($Dialog_Box.modulate.a>0):
		$Dialog_Box.modulate.a -= 0.05
		$Name_en.modulate.a -= 0.05
		$Name_jp.modulate.a -= 0.05
		$Timer.start(.01)
		await $Timer.timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func read_dialog(dialog):
	for line in dialog:
		dialog_sys.clear()
		await speech(line)
		$Timer.start(1.5)
		await $Timer.timeout
		dialog_sys.clear()

func speech(text):
	for c in text:
		$Voice.play()
		$Timer.start(.075)
		await $Timer.timeout
		dialog_sys.add_text(c)	
