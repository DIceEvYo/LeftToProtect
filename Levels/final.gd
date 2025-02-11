extends Control

var voice

var jas_facial_expression

var dialogue_sys
var dia_0
var dia_1
var dia_2

func load_dialogue():
	dialogue_sys = $Dialogue
	if Score.minilvl == 0:
		if Score.lang == "jp":
			$Jasmine.text = "ジャスミンちゃん"
			dia_0 = [
				"ふう、すっきりした！"
			]
			dia_1 = [
				"プレイしてくれてありがとうな～！"
			]
			dia_2 = [
				"ファイナルスコア： " + str(Score.total_score) + "。おめでとう！"
			]
		else:
			$Jasmine.text = "Jasmine"
			dia_0 = [
				"Well, that was refreshing!"
			]
			dia_1 = [
				"Thanks for playing!"
			]
			dia_2 = [
				"Final Score: " + str(Score.total_score) + ". Congrats!"
			]
	elif Score.minilvl == 3:
		if Score.lang == "jp":
			$Jasmine.text = "ジャスミンちゃん"
			dia_0 = [
				"俺を訪ねてくれたんだね～"
			]
			dia_1 = [
				"感動しちゃった～"
			]
			dia_2 = [
				"スコア： " + str(Score.total_score) + "。いいね～"
			]
		else:
			$Jasmine.text = "Jasmine"
			dia_0 = [
				"So you decided visit me~"
			]
			dia_1 = [
				"I'm flattered~"
			]
			dia_2 = [
				"Score: " + str(Score.total_score) + ". Well done!"
			]
	elif Score.minilvl == 2:
		if Score.lang == "jp":
			$Jasmine.text = "ジャスミンちゃん"
			dia_0 = [
				"ももこを訪ねてくれたんだね～"
			]
			dia_1 = [
				"かわいいものが好きだなんて知らなかった～"
			]
			dia_2 = [
				"スコア： " + str(Score.total_score) + "。いいね～"
			]
		else:
			$Jasmine.text = "Jasmine"
			dia_0 = [
				"So you decided to give Momoko a visit~"
			]
			dia_1 = [
				"I didn't knew you liked cute things~"
			]
			dia_2 = [
				"Score: " + str(Score.total_score) + ". Well done!"
			]
	elif Score.minilvl == 1:
		if Score.lang == "jp":
			$Jasmine.text = "ジャスミンちゃん"
			dia_0 = [
				"ゆうきを訪ねてくれたんだね～"
			]
			dia_1 = [
				"彼女は、完璧なターゲットじゃないか？"
			]
			dia_2 = [
				"スコア： " + str(Score.total_score) + "。いいね～"
			]
		else:
			$Jasmine.text = "Jasmine"
			dia_0 = [
				"So you decided to give Yuuki a visit~"
			]
			dia_1 = [
				"She makes for a great target wouldn't you agree~?"
			]
			dia_2 = [
				"Score: " + str(Score.total_score) + ". Well done!"
			]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialogue()
	$Jasmine.modulate.a = 100
	
	$Jasmine2.modulate.a = 100

	voice = $JasmineVoice
	await read_dialogue(dia_0)
	jas_facial_expression = load("res://JasmineCha/IMG_0066.PNG")
	$Jasmine2.texture = jas_facial_expression
	await read_dialogue(dia_1)
	$Jasmine.modulate.a = 0
	$GolemVoice.pitch_scale = 3
	voice = $GolemVoice
	await read_dialogue(dia_2)
	if Score.minilvl > 0:
		await get_tree().change_scene_to_file("res://Title Screen/title_screen.tscn")
	else:
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
		$Timer.start(.045)
		await $Timer.timeout
		dialogue_sys.add_text(c)

func _on_skip_button_pressed():
	queue_free()
