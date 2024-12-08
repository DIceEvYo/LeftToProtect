extends AnimatedSprite2D
class_name LeafBullet

const speed = 500
var leaf_type = "default":
	set(value):
		leaf_type = value
		play(leaf_type)
static var viewport_rect: Rect2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta
	#Removes bullet when it leaves the screen.
	if !viewport_rect.has_point(position):
		queue_free()
