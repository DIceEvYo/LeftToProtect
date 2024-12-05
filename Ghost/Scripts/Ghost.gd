extends RigidBody2D

var GhostBullet = preload("res://Ghost/Scenes/Bullets/GravityBullet.tscn")

var player = null

#General Variables
var speed = 0
var dir = Vector2.ZERO #Resets direction to default
var screen_size #Size of game window
var waiting = true
var angle = 0

#Rotator Related Bullet Patterns
var ghost_orb_scene = preload("res://Ghost/Scenes/Bullets/GhostOrb.tscn")
var phantom_ice_scene = preload("res://Ghost/Scenes/Bullets/PhantomIce.tscn")
var bakudan_bullet_scene = preload("res://Ghost/Scenes/Bullets/BakudanBullet.tscn")
var itazura_bullet_scene = preload("res://Ghost/Scenes/Bullets/ItazuraFlame.tscn")
var targetted_bullet_scene = preload("res://Ghost/Scenes/Bullets/TargettedBullet.tscn")
@onready var shoot_timer2 = $ShootTimer2
@onready var rotater = $Rotater
var rotate_speed = 100
var rs_mode = false
var ice = false

# Temporary health variable.
var health = 100

#Time specific Variables
#Dir Change
var change_dir_timer = 2.0 #How many seconds it takes for direction to change
var time_elapsed_dir = 0.0
#Shooting
var shoot_count = 0
var shoot_limit = 5

func _ready():
	#Finds size of game window
	screen_size = get_viewport_rect().size
	$Area2D/AnimatedSprite2D.play("idle")
	randomize()
	attack_sequence()
	#change_dir()

func rotational_shoot(set_rotate_speed, shoot_timer_wait_time, amount_to_shoot, radius):
	if rs_mode:
		rotate_speed = set_rotate_speed
		var rotate_step = 2*PI/amount_to_shoot
		for i in range(0, amount_to_shoot):
			var spawn_point = Node2D.new()
			var pos = Vector2(radius, 0).rotated(rotate_step*i)
			spawn_point.position = pos
			spawn_point.rotation = pos.angle()
			rotater.add_child(spawn_point)
		shoot_timer2.wait_time = shoot_timer2.wait_time
		shoot_timer2.start()

func _on_shoot_timer_2_timeout():
	if rs_mode:
		for s in rotater.get_children():
			if(ice):
				var phantom_ice = phantom_ice_scene.instantiate()
				get_tree().root.add_child(phantom_ice)
				phantom_ice.position = position
				phantom_ice.rotation = s.global_rotation
			else:
				var ghost_orb = ghost_orb_scene.instantiate()
				get_tree().root.add_child(ghost_orb)
				ghost_orb.position = position
				ghost_orb.rotation = s.global_rotation
			ice = !ice

func _process(delta):
	linear_velocity = dir * speed
	#print(position.y)
	#rotater.position = position
	if rs_mode:
		var new_rotation = rotater.rotation_degrees + rotate_speed * delta
		rotater.rotation_degrees = fmod(new_rotation, 360)
"""
	if not waiting:
		#Linear Velocity is a var specific to RigidBody2d that controls 
		#speed and direction on a given 2d plane. 
		linear_velocity = dir*speed
		#Uses delta (frame time) to calculate time elapsed
		time_elapsed_dir += delta
		check_bounds()
		if time_elapsed_dir > change_dir_timer:
			change_dir()
			time_elapsed_dir = 0
		#Prevents enemy from leaving the screen.
		#position = position.clamp(Vector2.ZERO, screen_size)
	else:
		linear_velocity = Vector2.ZERO
"""

#Reverses direction if touching edge.
func check_bounds():
	if position.x <= 0:
		dir.x = abs(dir.x)
		position.x = 1
	elif position.x >= screen_size.x:
		dir.x = -abs(dir.x)
		position.x = screen_size.x - 1
	if position.y <= 0:
		dir.y = abs(dir.y)
		position.y = 1
	elif position.y >= screen_size.y:
		dir.y = -abs(dir.y)
		position.y = screen_size.y - 1
		
#Changes direction to a random angle upon call.
func change_dir():
	#Randf generates random floating-point num between 0&1. TAU is 2π.
	#In other words angle selects a rand angle from 0 to 2π.
	var angle = randf() * TAU
	#Normalized keeps vector at length of 1 to prevent any side effects.
	dir = Vector2(cos(angle), sin(angle)).normalized()

func attack_sequence():
	#Ghost initializes her position
	await wait_for_timer(.5)
	speed = 2400
	custom_dir(0)
	drop_bakudan(5, 0.1)
	await wait_for_timer(0.34)
	#First attack
	#$BackgroundMusic.play()
	speed = 0
	rs_mode = true
	rotational_shoot(300, 0.1, 12, 100)
	#danmaku(4, .05)
	await wait_for_timer(0.25)
	#Move to center (2nd position)
	rs_mode = false
	speed = 2400
	custom_dir(PI)
	drop_bakudan(5, 0.1)
	await wait_for_timer(0.68)
	#Second Attack
	speed = 0
	#danmaku(4, .05)
	rs_mode = true
	rotational_shoot(-300, 0.1, 12, 100)
	await wait_for_timer(0.25)
	#Move to left (3rd position)
	rs_mode = false
	speed = 2400
	custom_dir((PI)/11)
	drop_bakudan(5, 0.1)
	await wait_for_timer(0.34)
	#Third Attack
	speed = 0
	rs_mode = true
	rotational_shoot(500, 0.1, 20, 100)
	await wait_for_timer(.25)
	#Move down (4th position)
	rs_mode = false
	speed = 2400
	custom_dir((PI)/2)
	await wait_for_timer(.28)
	#Fourth Attack
	speed = 0
	rs_mode = true
	rotational_shoot(500, 0.1, 20, 100)
	await wait_for_timer(.25)
	#Move up (before main set) As the ghost moves up, display attack illustration
	rs_mode = false
	speed = 800
	custom_dir((3*PI)/2)
	await wait_for_timer(.5)
	speed = 600
	await wait_for_timer(.8)
	speed = 0
	itazura(8, 0.05, 5)
	drop_bakudan(5, 0.1)
	await wait_for_timer(.8)
	itazura(8, 0.05, 5)
	drop_bakudan(5, 0.1)
	await wait_for_timer(2)
	diagonal_trick(8, 0.05, 5)
	drop_bakudan(5, 0.1)
	await wait_for_timer(2)
	rotate_me(20, 80, 10)
	rs_mode = true
	rotational_shoot(500, 0.1, 40, 100)
	await wait_for_timer(1)
	rotational_shoot(500, 0.1, 40, 100)
	await wait_for_timer(1)
	rs_mode = false
	target_shot(5, 0.4, 90)
	await wait_for_timer(.5)
	rs_mode = true
	rotational_shoot(500, 0.1, 40, 100)
	rotate_me(20, 80, -10)
	await wait_for_timer(1)
	rotational_shoot(500, 0.1, 40, 100)
	await wait_for_timer(1)
	rs_mode = false
	target_shot(5, 0.4, 90)
	await wait_for_timer(.5)	
	
func rotate_me(steps, radius, rot_speed):
	var angle = 0.0  #Current angle for circular motion
	var step_angle = rot_speed * (PI/180)  #Convert step angle to radians for smooth rotation
	for i in range(0, steps):
		await shoot_timer(0.08)  #Delay between each step (smoothness depends on this value)
		#Increment the angle
		angle += step_angle
		#Calculate the new position using the angle and radius
		var new_x = radius * cos(angle)
		var new_y = radius * sin(angle)
		#Set the position to move smoothly to the new target
		position += Vector2(new_x, new_y)

			
	
func wait_for_timer(duration):
	$WaitTimer.start(duration)  #Start the timer with the specified duration
	await $WaitTimer.timeout    #Wait until the timeout signal is emitted
	
func shoot_timer(duration):
	$ShootTimer.start(duration)  #Start the timer with the specified duration
	await $ShootTimer.timeout    #Wait until the timeout signal is emitted
	
#More control to direction change
func custom_dir(angle):
	dir = Vector2(cos(angle), sin(angle)).normalized()

func danmaku(bullets_to_shoot, shoot_delay):
	for i in range(0, bullets_to_shoot):
		await shoot_timer(shoot_delay)
		shoot(0)
		shoot(70)
		shoot(-70)
		
func target_shot(bullets_to_shoot, shoot_delay, pos_offset):
	for i in range(0, bullets_to_shoot):
		await shoot_timer(shoot_delay)
		var target_bullet_l = targetted_bullet_scene.instantiate()
		target_bullet_l.position = position
		target_bullet_l.position.x = position.x+pos_offset
		target_bullet_l.direction = global_position.direction_to(player.global_position)
		var target_bullet_r = targetted_bullet_scene.instantiate()
		target_bullet_r.position = position
		target_bullet_r.position.x = position.x-pos_offset
		target_bullet_r.direction = global_position.direction_to(player.global_position)
		get_parent().add_child(target_bullet_l)
		get_parent().add_child(target_bullet_r)
		
	
func shoot(pos_offset):
	var gbullet = GhostBullet.instantiate()
	gbullet.position = position
	gbullet.position.x = position.x + pos_offset
	get_parent().add_child(gbullet)

func drop_bakudan(bullets_to_shoot, shoot_delay):
	for i in range(0, bullets_to_shoot):
		await shoot_timer(shoot_delay)
		var bakudan = bakudan_bullet_scene.instantiate()
		get_tree().root.add_child(bakudan)
		bakudan.position = position
		bakudan.rotation = (PI)/2

func itazura(bullets_to_shoot, shoot_delay, rain):
	var speed = 200*bullets_to_shoot
	for i in range (0, bullets_to_shoot):
		await shoot_timer(shoot_delay)
		var itazura_flame_l = itazura_bullet_scene.instantiate()
		itazura_flame_l.speed += speed
		itazura_flame_l.position = position
		itazura_flame_l.rotation = PI
		var itazura_flame_r = itazura_bullet_scene.instantiate()
		itazura_flame_r.speed += speed
		itazura_flame_r.position = position
		itazura_flame_r.rotation = 0
		for j in range(0, rain):
			get_parent().add_child(itazura_flame_l)
			get_parent().add_child(itazura_flame_r)
		speed -= 200
		
func diagonal_trick(bullets_to_shoot, shoot_delay, rain):
	var speed = 200*bullets_to_shoot
	for i in range (0, bullets_to_shoot):
		await shoot_timer(shoot_delay)
		var itazura_flame_l = itazura_bullet_scene.instantiate()
		itazura_flame_l.speed += speed
		itazura_flame_l.position = position
		itazura_flame_l.rotation = (5*PI)/6
		var itazura_flame_r = itazura_bullet_scene.instantiate()
		itazura_flame_r.speed += speed
		itazura_flame_r.position = position
		itazura_flame_r.rotation = (PI)/6
		for j in range(0, rain):
			get_parent().add_child(itazura_flame_l)
			get_parent().add_child(itazura_flame_r)
		speed -= 200

func uShotLeft1():
	var gbullet = GhostBullet.instantiate()
	gbullet.position.y = position.y
	gbullet.position.x = position.x - 10
	
	
# When called, kills maid.
func kill():
	get_tree().reload_current_scene()
	
	
func take_damage() -> void:
	health -= 10
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Bullet" == body.name:
		# Reduce health.
		take_damage()
		
	# Calls for player to take damage.
	elif "Player" == body.name:
		body.take_damage()
		
	if health <= 0:
		kill()
