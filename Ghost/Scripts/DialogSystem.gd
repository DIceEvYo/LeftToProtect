extends Control

var facial_expression
var dialog_1 = [
	"Zzz...",
	"Zzz...",
	"...Hmm wha-? Nnno.. let me rest for 5 more minutes...",
	"...zzz",
	"... z z z ...?"
]
var dialog_2 = [
	"HWEH!?!?",
]
var dialog_3 = [
	"WHO DA HECK ARE YOU!?",	
]
var dialog_4 = [
	"HUH-!? You saw me sleeping-???",
]
var dialog_4_5 = [
	"You're kind of weird for that, but NO-!"
]
var dialog_4_7 = [
	"I was just... Umm..."
]
var dialog_5 = [
	"I WAS JUST TESTING YOUR ABILITIES! I KNEW YOU WERE HERE THE WHOLE TIME!",
]
var dialog_5_1 = [
	"NOTHING EVER GETS PASSED ME!",
]
var dialog_5_2 = [
	"YEAH! THAT'S RIGHT! YOU FELL FOR IT DUMB DUMB!!!",
]
var dialog_6 = [
	"I totally wasn't sleeping.. or anything-!"
]
var dialog_7 = [
	"Anyway... What brings a nonhuman to the underrealm?"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	facial_expression = load("res://Ghost/幽霊イラスト/寝ている/怠け者.png")
	$GhostIllust.texture = facial_expression
	$AnimationPlayer.play("fade_in")
	$DialogueBG.play()
	await read_dialog(dialog_1)
	facial_expression = load("res://Ghost/幽霊イラスト/へえええ？？/来るな！.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_2)
	facial_expression = load("res://Ghost/幽霊イラスト/へえええ？？/あれれれ？？.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_3)
	facial_expression = load("res://Ghost/幽霊イラスト/悲しい!！/うわっ！.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_4)
	facial_expression = load("res://Ghost/幽霊イラスト/怒っている/頭にくる！.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_4_5)
	facial_expression = load("res://Ghost/幽霊イラスト/ふんん。。。？/なんだ？.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_4_7)
	facial_expression = load("res://Ghost/幽霊イラスト/ニヤニヤ/目を瞑っている.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_5)	
	facial_expression = load("res://Ghost/幽霊イラスト/ニヤニヤ/只管２.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_5_1)	
	facial_expression = load("res://Ghost/幽霊イラスト/ニヤニヤ/只管１.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_5_2)	
	facial_expression = load("res://Ghost/幽霊イラスト/ふん！/仏頂面.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_6)
	$AnimationPlayer.play("fade_out")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func read_dialog(dialog):
	for line in dialog:
		$Dialog.clear()
		await speech(line)
		$Timer.start(1.5)
		await $Timer.timeout
		$Dialog.clear()

func speech(text):
	for c in text:
		$Voice.play()
		$Timer.start(.075)
		await $Timer.timeout
		$Dialog.add_text(c)	
