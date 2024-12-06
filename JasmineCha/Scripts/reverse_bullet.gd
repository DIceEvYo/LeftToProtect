extends Node2D

var speed = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	$AnimatedSprite2D.play("default")
	$WaitTimer.start(.4)
	await $WaitTimer.timeout
	speed = 0-speed
	$AnimatedSprite2D.play("reverse")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta
	#Removes bullet when it leaves the screen.
	if !get_viewport_rect().has_point(position):
		queue_free()
