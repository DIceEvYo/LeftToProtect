extends AnimatedSprite2D

var speed = 5 #bullets go brrrr#
var dir = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	position.x += dir.x * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += dir * speed
	rotation = (dir.angle()-(PI/2))
	if !get_viewport_rect().has_point(position):
		queue_free()
