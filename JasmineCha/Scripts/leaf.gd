extends AnimatedSprite2D
class_name LeafBullet

const speed = 500
var leaf_type = "default":
	set(value):
		leaf_type = value
		play(leaf_type)
static var viewport_rect: Rect2
var dead := false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta
	#Removes bullet when it leaves the screen.
	if !viewport_rect.has_point(position):
		_dead()

func reset() -> void:
	dead = false
	leaf_type = "default"
	position = Vector2.ZERO
	set_process(true)
	visible = true

func _dead() -> void:
	set_process(false)
	visible = false
	dead = true
