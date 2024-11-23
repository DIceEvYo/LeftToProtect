extends Node2D

var speed = 100

func _ready():
	#Allows bullet to leave the screen bounds.
	set_as_top_level(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta

	if !get_viewport_rect().has_point(position):
		queue_free()
