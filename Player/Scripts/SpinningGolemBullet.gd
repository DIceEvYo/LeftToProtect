extends RigidBody2D

var bullet_speed : int = 1000
var direction = Vector2.ZERO
var spinning_multiplier : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("spinning_golem_bullet")
	# Initial velocity.
	linear_velocity = direction * bullet_speed
	# Gravity bye-bye.
	gravity_scale = 0
	# Sets rotation to match movement direction.
	#rotation = direction.angle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta: float ) -> void:
	position += direction * bullet_speed * delta
	
	if !get_viewport_rect().has_point(position):
		queue_free()
		
		
func _physics_process( delta : float ) -> void:
	# Keeps bullet moving.
	linear_velocity = direction * bullet_speed
	

# Checks if maid or maid bullet enters.
func _on_area_2d_area_entered(area: Area2D) -> void:
	# If it was maid bullet, removes it from sight and increase size.
	if "Body" in area.get_parent().name:
		area.get_parent().visible = false
		area.queue_free()
		spinning_multiplier += 1
		$AnimatedSprite2D.scale.x *= 1.2
		$AnimatedSprite2D.scale.y *= 1.2
		$CollisionShape2D.scale.x *= 1.2
		$CollisionShape2D.scale.y *= 1.2
		
	# If maid, deals damage.
	elif "Maid" == area.get_parent().name:
		area.get_parent().take_damage(spinning_multiplier * 10)
