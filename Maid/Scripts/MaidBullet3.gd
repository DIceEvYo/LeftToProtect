extends Node2D

var speed = 500
var kirakira = preload("res://Maid/Scenes/MaidBullet35.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KiraKiraTimer.start(1)
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta

	if !get_viewport_rect().has_point(position):
		queue_free()


func _on_kira_kira_timer_timeout() -> void:
	for i in range(8):
		var maidbullet35 = kirakira.instantiate()
		get_tree().root.add_child(maidbullet35)
		maidbullet35.position = position
		maidbullet35.rotation = i * PI / 4
