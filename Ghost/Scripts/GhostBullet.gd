extends RigidBody2D

var speed = 300
var dir = Vector2.ZERO

func _ready():
	#Allows bullet to leave the screen bounds.
	set_as_top_level(true)

func _process(delta):
	position += dir * speed * delta
	#Removes bullet when it leaves the screen.
	if !get_viewport_rect().has_point(position):
		queue_free()
