extends AnimatedSprite2D

var speed = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta
	#Debugging print statement
	#print("Pos y", position.y, "Global", global_position.y)
	if position.y > 2746:
		queue_free()
