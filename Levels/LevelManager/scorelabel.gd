extends Label

func _process(delta):
	if Score.lang == "jp":
		self.text = "スコア： " + str(Score.score)
	else:
		self.text = "Score: " + str(Score.score)
