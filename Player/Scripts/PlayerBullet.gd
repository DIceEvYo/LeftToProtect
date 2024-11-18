extends RigidBody2D

var bullet_speed : int = 1000
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initial velocity.
	linear_velocity = direction * bullet_speed
	# Gravity bye-bye.
	gravity_scale = 0
	# Sets rotation to match movement direction.
	rotation = direction.angle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * bullet_speed * delta
	
	if !get_viewport_rect().has_point(position):
		queue_free()
		
	
func _physics_process( delta : float ) -> void:
	# Keeps bullet moving.
	linear_velocity = direction * bullet_speed
	
