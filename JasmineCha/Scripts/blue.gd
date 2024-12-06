extends Node2D

const speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta
	#Removes bullet when it leaves the screen.
	if !get_viewport_rect().has_point(position):
		queue_free()
