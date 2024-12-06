extends Node2D

const speed = 20
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("comet")
	set_as_top_level(true)
	$WaitTimer.start(1) 
	position.x += direction.x * speed
	#Start the timer with the specified duration
	await $WaitTimer.timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	position += direction * speed
	rotation = (direction.angle()-(PI/2))
	#scale += Vector2(1, 1)
	#Removes bullet when it leaves the screen.
	if !get_viewport_rect().has_point(position):
		queue_free() 


func _on_area_2d_body_entered(body):
	if body == Player:
		queue_free()
