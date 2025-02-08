extends RigidBody2D

var movement_speed = 250
var direction = Vector2.ZERO
var alive = true


# Temporary Golem bullet. Change size later.
var bullet = preload("res://Player/bullet.tscn")
var bullet_speed = 2000
var shoot_cooldown = false

# Determines if baby will do anything.
var process = false
# Used to limit number of overlap checks.
var overlap_check = true
# Target of golems.
var enemies
var target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Alive_Duration").start()
	# Initial velocity.
	linear_velocity = direction * movement_speed
	# Gravity bye-bye.
	gravity_scale = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Dequeues when alive for 15 seconds.
	if not alive:
		queue_free()
		
	# Meant to limit the number of times for checking overlapping areas.
	if overlap_check:
		get_node("Overlap_Check").start()
		overlap_check = false
		
		## Get's overlapping areas. Will detect maid. Can get position there.
		#enemies = get_child(1).get_overlapping_areas()

	# Prevents firing if no enemy in vicinity.
	#if enemies.is_empty():
		#process = false
		
	# Allows firing, sets target, and sets linear velocity of bullet.
	else:	
		process = true
		if (not(target==null)):
			target = enemies[0]
		linear_velocity = direction * movement_speed
		
		# Fixes problem with "freed"
		if (not(target==null)):
			if is_instance_valid(target):
				direction = (target.global_position - position).normalized()
	


func _physics_process( delta : float ) -> void:
	# Updates baby golem's position.
	position += direction * movement_speed * delta
	
	# Checks to make sure baby golem can fire properly.
	if process:
		if shoot_cooldown:
			pass
		else:
			# Fixes problem with "freed"
			if (not(target==null)):
				if is_instance_valid(target):
					fire()
	
	
func fire():
	var bullet_instance
	
	# New regular bullet.
	bullet_instance = bullet.instantiate()
	
	# Calculates direction of enemy.
	if (not(target==null)):
		bullet_instance.direction = (target.global_position - position).normalized()
	
		# Bullet placed at player position before added to scene (check def later)
		bullet_instance.position = position
		get_parent().add_child(bullet_instance)
		get_node("Shoot_Delay").start()
	shoot_cooldown = true


func _on_shoot_delay_timeout() -> void:
	shoot_cooldown = false
	


func _on_alive_duration_timeout() -> void:
	alive = false


func _on_overlap_check_timeout() -> void:
	overlap_check = true
