extends Control

var voice

var maid_facial_expression
var ghost_facial_expression
var jas_facial_expression
var golem
var boss
var time

var dialogue_sys
var dia_0
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
	if Score.lang == "jp":
		$MaidName.text = "ももこ"
		$GhostName.text = "ゆうき"
		$GolemName.text = "ゴーレム"
		$GolemMinion.text = "ゴーレムのミニオン"
		$Jasmine.text = "ジャスミンちゃん"
		$SkipButton.text = "スキップ"
		time = .065
		dia_0 = [
		"。。。"
		]
		dia_1 = [
			"傷つけるなんて、できませんわ！"
		]
		dia_2 = [
			"ゴレムきゅんは可愛らしすぎて、胸がいっぱいでございます！"
		]
		dia_3 = [
			"変なあんたらは何なんだ！？こんな関係に参加したくねぇ！家に帰りたい！！"
		]
		dia_4 = [
			"あら、家に帰りたいかしら？運がいいじゃん、ちょうど家に着いたところみたいだね"
		]
		dia_5 = [
			"ハッ？！"
		]
		dia_6 = [
			"けど、お前らのうるせぇでたらめのせいで、気分は全然愉快じゃねぇ。"
		]
		dia_7 = [
			"しかし、運のいいことに、俺の前に三人のターゲットが現れやがったみたいだな～あらあら～"
		]
		dia_8 = [
			"いや、俺を含めれば四人だ。クローンたちなら、もっとだ。"
		]
		dia_9 = [
			"そう？素敵だな～じゃあ、ぶっ壊す準備はできてんだろうな～"
		]
		dia_10 = [
			"きゃっ！！！"
		]
		dia_11 = [
			"ゴレムきゅん～えへへ"
		]
		dia_12 = [
			"どうでもいい。"
		]
		dia_13 = [
			"土。"
		]
		dia_14 = [
			"よ　う　こ　そ　、　お　茶　の　店　へ"
		]
	else:
		$MaidName.text = "Momoko"
		$GhostName.text = "Yuuki"
		$GolemName.text = "Golem"
		$GolemMinion.text = "Golem Minion"
		$Jasmine.text = "Jasmine"
		$SkipButton.text = "Skip"
		time = .045
		dia_0 = [
			"I..."
		]
		dia_1 = [
			"I can't hurt him!"
		]
		dia_2 = [
			"GOLEM-KYUN IS TOO CUTE-!!!"
		]
		dia_3 = [
			"What is with you weirdos!? I don't want to be part of this-! I wanna go home!!"
		]
		dia_4 = [
			"Luckily for you, it appears you have reached a home~"
		]
		dia_5 = [
			"HAH-?!"
		]
		dia_6 = [
			"Although I must say I'm not in a pleasant mood after all the needless ruckus going on outside."
		]
		dia_7 = [
			"Fortunantly, it seems three free targets have appeared before me~"
		]
		dia_8 = [
			"Actually, it's four if you include me, more if you consider the clones."
		]
		dia_9 = [
			"Really? That sounds delightful~ Well, I hope you're all ready to be crushed~"
		]
		dia_10 = [
			"EEEEK!!!"
		]
		dia_11 = [
			"Golem-kyun heheheh..."
		]
		dia_12 = [
			"Eh."
		]
		dia_13 = [
			"Dirt."
		]
		dia_14 = [
			"W e l c o m e    t o   t h e   t e a   h o u s e"
		]

# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogueBGM.play()
	load_dialogue()
	$MaidName.modulate.a = 0
	$GhostName.modulate.a = 0
	$GolemName.modulate.a = 0
	$GolemMinion.modulate.a = 0
	$Jasmine.modulate.a = 0
	
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_dark.png")
	ghost_facial_expression = load("res://Ghost/Illustrations/Whaaat？？/arerere.png")
	$GhostIllust.texture = ghost_facial_expression
	$MaidIllust.texture = maid_facial_expression
	
	$GhostIllust.modulate.a = 0
	$Jasmine2.modulate.a = 0
	$MaidIllust.modulate.a = 0
	
	
	#MAID
	$MaidName.modulate.a = 100
	$GhostIllust.modulate.a = 1
	$MaidIllust.modulate.a = 100
	voice = $MaidVoice
	await read_dialogue(dia_0)
	
	#MAID
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_dx.png")
	ghost_facial_expression = load("res://Ghost/Illustrations/Whaaat？？/dontcomeclose!.png")
	$GhostIllust.texture = ghost_facial_expression
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_1)
	
	#MAID
	maid_facial_expression = load("res://Maid/Sprites/MaidIllustrations/maidillus_love.png")
	ghost_facial_expression = load("res://Ghost/Illustrations/sad!!/uwah!.png")
	$GhostIllust.texture = ghost_facial_expression
	$MaidIllust.texture = maid_facial_expression
	await read_dialogue(dia_2)
	
	#YUUKI
	$MaidName.modulate.a = 0
	$GhostName.modulate.a = 100
	voice = $GhostVoice
	await read_dialogue(dia_3)
	$DialogueBGM.stop()
	
	#JASMINE
	$Jasmine.modulate.a = 100
	$GhostName.modulate.a = 0
	ghost_facial_expression = load("res://Ghost/Illustrations/Whaaat？？/dontcomeclose!.png")
	$GhostIllust.texture = ghost_facial_expression
	voice = $JasmineVoice
	await read_dialogue(dia_4)	
	
	#YUUKI
	$DialogueBGM2.play()
	jas_facial_expression = load("res://JasmineCha/Background/Jasmine.png")
	$Jasmine2.texture = jas_facial_expression
	$Jasmine2.modulate.a = 100
	$GhostName.modulate.a = 100
	$Jasmine.modulate.a = 0
	ghost_facial_expression = load("res://Ghost/Illustrations/sad!!/uwah!.png")
	$GhostIllust.texture = ghost_facial_expression
	voice = $GhostVoice
	await read_dialogue(dia_5)
	
	#JASMINE
	$Jasmine.modulate.a = 100
	jas_facial_expression = load("res://JasmineCha/IMG_0068.PNG")
	$Jasmine2.texture = jas_facial_expression
	$GhostName.modulate.a = 0
	ghost_facial_expression = load("res://Ghost/Illustrations/Whaaat？？/dontcomeclose!.png")
	$GhostIllust.texture = ghost_facial_expression
	voice = $JasmineVoice
	await read_dialogue(dia_6)	
	
	#JASMINE
	jas_facial_expression = load("res://JasmineCha/IMG_0067.PNG")
	$Jasmine2.texture = jas_facial_expression
	await read_dialogue(dia_7)
	
	#GOLEM MINION
	jas_facial_expression = load("res://JasmineCha/Background/Jasmine.png")
	$Jasmine2.texture = jas_facial_expression
	$Jasmine.modulate.a = 0
	$GolemMinion.modulate.a = 100
	$GolemVoice.pitch_scale = 3
	voice = $GolemVoice
	await read_dialogue(dia_8)	
	
	#JASMINE
	jas_facial_expression = load("res://JasmineCha/IMG_0066.PNG")
	$Jasmine2.texture = jas_facial_expression
	$Jasmine.modulate.a = 100
	$GolemMinion.modulate.a = 0
	voice = $JasmineVoice
	await read_dialogue(dia_9)
	
	#GHOST
	$Jasmine.modulate.a = 0
	$GhostName.modulate.a = 100
	voice = $GhostVoice
	await read_dialogue(dia_10)
	
	#MAID
	$GhostName.modulate.a = 0
	$MaidName.modulate.a = 100
	voice = $MaidVoice
	await read_dialogue(dia_11)

	#GOLEM MINION
	$MaidName.modulate.a = 0
	$GolemMinion.modulate.a = 100
	$GolemVoice.pitch_scale = 3
	voice = $GolemVoice
	await read_dialogue(dia_12)
	
	#GOLEM
	$GolemMinion.modulate.a = 0
	$GolemName.modulate.a = 100
	$GolemVoice.pitch_scale = 1
	voice = $GolemVoice
	await read_dialogue(dia_13)

	#Jasmine
	$DialogueBGM2.stop()
	jas_facial_expression = load("res://JasmineCha/IMG_0068.PNG")
	$Jasmine2.texture = jas_facial_expression
	$GolemName.modulate.a = 0
	$Jasmine.modulate.a = 100
	voice = $JasmineVoice
	await read_dialogue(dia_14)
	
	queue_free()



signal continue_dialog
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		continue_dialog.emit()

func read_dialogue(dialogue):
	for line in dialogue:
		dialogue_sys.clear()
		await speech(line)
		await continue_dialog
		dialogue_sys.clear()

func speech(text):
	for c in text:
		voice.play()
		$Timer.start(time)
		await $Timer.timeout
		dialogue_sys.add_text(c)

func _on_skip_button_pressed():
	queue_free()
