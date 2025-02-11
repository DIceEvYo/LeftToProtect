extends Label

var show_score

func _process(delta):
	if Score.minilvl > 0:
		show_score = Score.score
	else:
		show_score = Score.total_score + Score.score
	if Score.lang == "jp":
		self.text = "スコア： " + str(show_score)
	else:
		self.text = "Score: " + str(show_score)
