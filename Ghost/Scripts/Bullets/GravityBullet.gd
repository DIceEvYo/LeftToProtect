extends RigidBody2D

func _ready():
	#Allows bullet to leave the screen bounds.
	$AnimatedSprite2D.play("flame")
	set_as_top_level(true)
func _process(_delta):
	#Removes bullet when it leaves the screen.
	if !get_viewport_rect().has_point(position):
		queue_free()
