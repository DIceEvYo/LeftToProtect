extends Control

func _ready():
	if Score.lang == "jp":
		$CanvasLayer/Container/VBoxContainer/Quit.text = "終了"
		$CanvasLayer/Container/VBoxContainer/MainMenu.text = "メインメニュー"
		$CanvasLayer/Container/VBoxContainer/Retry.text = "リトライ"
		$CanvasLayer/Container/VBoxContainer/Continue.text = "コンティニュー"
	else:
		$CanvasLayer/Container/VBoxContainer/Quit.text = "Quit"
		$CanvasLayer/Container/VBoxContainer/MainMenu.text = "Main Menu"
		$CanvasLayer/Container/VBoxContainer/Retry.text = "Retry"
		$CanvasLayer/Container/VBoxContainer/Continue.text = "Continue"
	resume()

func pause():
	get_tree().paused = true
	$ColorRect.visible = true
	$ColorRect2.visible = true
	$CanvasLayer/Container.visible = true
	
func resume():
	get_tree().paused = false
	$ColorRect.visible = false
	$ColorRect2.visible = false
	$CanvasLayer/Container.visible = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu") and !get_tree().paused:
		pause()
	elif event.is_action_pressed("menu") and get_tree().paused:
		resume()

func _on_continue_pressed():
	resume()


func _on_retry_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed():
	resume()
	get_tree().quit()


func _on_main_menu_pressed():
	resume()
	get_tree().change_scene_to_file("res://Title Screen/title_screen.tscn")
