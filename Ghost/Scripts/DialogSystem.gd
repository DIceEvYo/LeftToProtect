extends Control

var jp = false
var facial_expression

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
var dialog_8
var dialog_9
var dialog_10
var dialog_11
var dialog_12
var dialog_13
var dialog_14

func load_dialog():
	if jp:
		$Name_en.modulate.a = 0
		dialog_sys = $DialogJP
		dialog_1 = [
		"スースー",
		"スースー。。。",
		"。。。んん？ なに？ いや。。 もっと5分。。。",
		"。。。スースー",
		"。。。 スースー?"
		]
		dialog_2 = [
			"へえええ!?!?",
		]
		dialog_3 = [
			"あんた一体誰！？",	
		]
		dialog_4 = [
			"え-!? ずっと寝ているって見たんだか、あんた！？",
		]
		dialog_4_5 = [
			"変な奴だな。。。でもいや！"
		]
		dialog_4_7 = [
			"僕はただ。。。 あの。。その。。。"
		]
		dialog_5 = [
			"あんたの能力を試していたんだ！ あんたがここにいたのはずっと知っていたんだ！！！",
		]
		dialog_5_1 = [
			"僕は無敵だ！",
		]
		dialog_5_2 = [
			"そうだ！そうだ！ 騙されてしまったんだな、あんた！",
		]
		dialog_6 = [
			"ずっと寝ることでもしていねえぞ！"
		]
		dialog_7 = [
			"Anyway... What brings a nonhuman to the underrealm?"
		]
	else:
		$Name_jp.modulate.a = 0
		dialog_sys = $Dialog
		dialog_1 = [
			"Zzz...",
			"...Hmm wha-? No.. just let me rest for 5 more minutes...",
			"...?",
		]
		dialog_2 = [
			"HWEH!?!?",
		]
		dialog_3 = [
			"WHO DA HECK ARE YOU!?",	
		]
		dialog_4 = [
			"HUH-!? You saw me sleeping THIS ENTIRE TIME-???",
		]
		dialog_4_5 = [
			"You're kind of weird for that, but NO-!"
		]
		dialog_4_7 = [
			"I was just... Umm..."
		]
		dialog_5 = [
			"I WAS JUST TESTING YOUR ABILITIES! I KNEW YOU WERE HERE THE ENTIRE TIME!",
		]
		dialog_5_1 = [
			"NOTHING EVER GETS PAST ME!",
		]
		dialog_5_2 = [
			"Not even dirt?",
		]
		dialog_6 = [
			"Dirt-? What are you talking about-?"
		]
		dialog_7 = [
			"(Throws dirt)"
		]
		dialog_8 = [
			"..Did you just throw dirt at me?"
		]
		dialog_9 = [
			"Dirt."
		]
		dialog_10 = [
		"Why yes~ He just did~ Would you like some more?"	
		]
		dialog_11 = [
			"EWWWWWWW!!!",
			"GET AWAY FROM ME!!!!"
		]
		dialog_12 = [
			"She actually meant to say 'WOOOAAH! THROW IT AT ME!'"
		]
		dialog_13 = [
			"NOOOOOOOO!!!!"
		]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Voice.pitch_scale = 0
	$Golem.modulate.a = 0
	$GolemMinion.modulate.a = 0
	load_dialog()
	
	facial_expression = load("res://Ghost/Illustrations/sleepy/lazy.png")
	$GhostIllust.texture = facial_expression
	$AnimationPlayer.play("fade_in")
	$DialogueBG.play()
	await read_dialog(dialog_1)
	
	facial_expression = load("res://Ghost/Illustrations/Whaaat？？/dontcomeclose!.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_2)
	
	facial_expression = load("res://Ghost/Illustrations/Whaaat？？/arerere.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_3)
	
	facial_expression = load("res://Ghost/Illustrations/sad!!/uwah!.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_4)
	
	facial_expression = load("res://Ghost/Illustrations/hmmm？/what is it.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_4_5)
	
	facial_expression = load("res://Ghost/Illustrations/hmmm？/what are you saying.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_4_7)
	
	facial_expression = load("res://Ghost/Illustrations/smile/closingeyessmiling.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_5)	
	
	facial_expression = load("res://Ghost/Illustrations/smile/smirk.png")
	$GhostIllust.texture = facial_expression
	await read_dialog(dialog_5_1)	
	
	#GOLEMINION
	facial_expression = load("res://Ghost/Illustrations/hmmm？/what are you saying.png")
	$GhostIllust.texture = facial_expression
	$GolemMinion.modulate.a = 100
	$Name_en.modulate.a = 0
	$Golem.modulate.a = 0
	$Voice2.pitch_scale = 3
	await read_dialog2(dialog_5_2)	
	
	
	#YUUKI
	facial_expression = load("res://Ghost/Illustrations/hmmm？/what is it.png")
	$GhostIllust.texture = facial_expression
	$GolemMinion.modulate.a = 0
	$Name_en.modulate.a = 100
	$Golem.modulate.a = 0
	await read_dialog(dialog_6)
	
	$DialogueBG.stop()
	#GOLEM
	facial_expression = load("res://Ghost/Illustrations/sad!!/uwah!.png")
	$GhostIllust.texture = facial_expression
	$Voice2.pitch_scale = 1
	$GolemMinion.modulate.a = 0
	$Name_en.modulate.a = 0
	$Golem.modulate.a = 100
	await read_dialog2(dialog_7)

	
	#YUUKI
	facial_expression = load("res://Ghost/Illustrations/angry/. . ..png")
	$GhostIllust.texture = facial_expression
	$GolemMinion.modulate.a = 0
	$Name_en.modulate.a = 100
	$Golem.modulate.a = 0
	await read_dialog(dialog_8)

	
	#GOLEM
	$Voice2.pitch_scale = 1
	$GolemMinion.modulate.a = 0
	$Name_en.modulate.a = 0
	$Golem.modulate.a = 100
	await read_dialog2(dialog_9)
	
	
	#GOLEMINION
	$GolemMinion.modulate.a = 100
	$Name_en.modulate.a = 0
	$Golem.modulate.a = 0
	$Voice2.pitch_scale = 3
	await read_dialog2(dialog_10)
	
	
	#YUUKI
	facial_expression = load("res://Ghost/Illustrations/Whaaat？？/arerere.png")
	$GhostIllust.texture = facial_expression
	$GolemMinion.modulate.a = 0
	$Name_en.modulate.a = 100
	$Golem.modulate.a = 0
	$Voice.pitch_scale = 2
	await read_dialog3(dialog_11)

	
	#GOLEMINION
	facial_expression = load("res://Ghost/Illustrations/Whaaat？？/dontcomeclose!.png")
	$GhostIllust.texture = facial_expression
	$Voice2.pitch_scale = 3
	$GolemMinion.modulate.a = 100
	$Name_en.modulate.a = 0
	$Golem.modulate.a = 0
	await read_dialog2(dialog_12)
	
	
	#YUUKI
	facial_expression = load("res://Ghost/Illustrations/sad!!/uwah!.png")
	$GhostIllust.texture = facial_expression
	$GolemMinion.modulate.a = 0
	$Name_en.modulate.a = 100
	$Golem.modulate.a = 0
	$Voice.pitch_scale = 2	
	await read_dialog3(dialog_13)
	
	
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
		$Timer.start(.065)
		await $Timer.timeout
		dialog_sys.add_text(c)	
		
func read_dialog2(dialog):
	for line in dialog:
		dialog_sys.clear()
		await speech2(line)
		$Timer.start(1.5)
		await $Timer.timeout
		dialog_sys.clear()

func speech2(text):
	for c in text:
		$Voice2.play()
		$Timer.start(.035)
		await $Timer.timeout
		dialog_sys.add_text(c)	
		
func read_dialog3(dialog):
	for line in dialog:
		dialog_sys.clear()
		await speech(line)
		$Timer.start(.75)
		await $Timer.timeout
		dialog_sys.clear()

func speech3(text):
	for c in text:
		$Voice.play()
		$Timer.start(.005)
		await $Timer.timeout
		dialog_sys.add_text(c)


func _on_skip_button_pressed():
	queue_free()
