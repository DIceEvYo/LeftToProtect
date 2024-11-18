extends RigidBody2D

var initial_speed = 200               # Initial horizontal speed to the left
var downward_acceleration = 50        # Acceleration for the downward curve
var velocity = Vector2(-initial_speed, 0)  # Start moving left

func _ready():
	# Set the initial velocity to move leftward
	linear_velocity = velocity

func _physics_process(delta):
	# Gradually add downward velocity to create a curve
	linear_velocity.y += downward_acceleration * delta

	# Optional: Delete the bullet if it goes off screen
	if position.y > get_viewport().size.y:
		queue_free()
