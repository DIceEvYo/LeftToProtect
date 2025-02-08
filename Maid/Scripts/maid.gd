extends RigidBody2D

signal hit

var player = null
var MaidBullet = preload("res://Maid/Scenes/MaidBullet.tscn")
var MaidBullet4 = preload("res://Maid/Scenes/MaidBullet4.tscn")
var bullet = MaidBullet


#Rotating bullet
var MaidBullet2 = preload("res://Maid/Scenes/MaidBullet2.tscn")
var MaidBullet3 = preload("res://Maid/Scenes/MaidBullet3.tscn")
var MaidBullet5 = preload("res://Maid/Scenes/MaidBullet5.tscn")
var rotate = MaidBullet2
@onready var shoot_timer3 = $Timer3
@onready var rotater = $Rotater
var rotate_speed = 100
var shooter_timer_wait_time = 0.2

#General Vars
var health = 30
var speed = 0
var dir = Vector2.ZERO #Resets direction to default
var screen_size #Size of game window
var waiting = true

#Time specific Variables
#Dir Change
var change_dir_timer = 2.0 #How many seconds it takes for direction to change
var time_elapsed_dir = 0.0
#Shooting
var shoot_count = 0
var shoot_limit = 5

func _ready():
	#Finds size of game window.
	$AnimatedSprite2D.play("default")
	screen_size = get_viewport_rect().size
	randomize()
	#change_dir()
	fight()

func rotational_shoot(set_rotational_speed, shoot_timer_wait_time, amount_to_shoot, radius):
	
	rotate_speed = set_rotational_speed
	var step = 2 * PI / amount_to_shoot
		
	for i in range(amount_to_shoot):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
			
	shoot_timer3.wait_time = shoot_timer_wait_time
	shoot_timer3.start()

func _process(delta):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)
	linear_velocity = dir * speed
#
	#if not waiting:
		##Linear Velocity is a var specific to RigidBody2d that controls 
		##speed and direction on a given 2d plane. 
		#linear_velocity = dir*speed
		##Uses delta (frame time) to calculate time elapsed
		#time_elapsed_dir += delta
		#check_bounds()
		#if time_elapsed_dir > change_dir_timer:
			#change_dir()
			#time_elapsed_dir = 0
		##Prevents enemy from leaving the screen.
		##position = position.clamp(Vector2.ZERO, screen_size)
		#position += linear_velocity
	#else:
		#linear_velocity = Vector2.ZERO

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
#func change_dir():
	#wait()
	##Randf generates random floating-point num between 0&1. TAU is 2π.
	##In other words angle selects a rand angle from 0 to 2π.
	#var angle = randf() * TAU
	##Normalized keeps vector at length of 1 to prevent any side effects.
	#dir = Vector2(cos(angle), sin(angle)).normalized()

#func wait():
	#waiting = true
	#speed = 0
	#dir = Vector2.ZERO
	##Makes maid wait 1 second.
	#get_node("Timer").start()
	#get_node("Timer2").start()
	#
#func _on_timer_timeout():
	#waiting = false
	#speed = 1000
	#
#func _on_timer_2_timeout():
	#if waiting:
		#shoot()

func shoot():
	var bullet = MaidBullet.instantiate()
	bullet.position = position
	bullet.dir = (Vector2(0, 1)).normalized()
	get_parent().add_child(bullet)


# When called, kills maid.
func kill():
	queue_free()
	
	
func take_damage( value : int ) -> void:
	print(value)
	health -= value
	
	if health <= 0:
		kill()

func _on_timer_3_timeout() -> void:
	for s in rotater.get_children():
		if rotate == MaidBullet2:
			var bullet = MaidBullet2.instantiate()
			get_tree().root.add_child(bullet)
			bullet.position = s.global_position
			bullet.rotation = s.global_rotation
		elif rotate == MaidBullet3:
			var bullet = MaidBullet3.instantiate()
			get_tree().root.add_child(bullet)
			bullet.position = s.global_position
			bullet.rotation = s.global_rotation
		elif rotate == MaidBullet5:
			var bullet = MaidBullet5.instantiate()
			get_tree().root.add_child(bullet)
			bullet.position = s.global_position
			bullet.rotation = s.global_rotation
		rotater.remove_child(s)

func custom_dir(angle):
	dir = Vector2(cos(angle), sin(angle)).normalized()
	
func wait_for_timer(duration):
	$Timer.start(duration)  #Thanks Dev
	await $Timer.timeout
	
func shoot_timer(duration):
	$Timer2.start(duration) 
	await $Timer2.timeout
	
func target_bullets(bullets_to_shoot, shoot_delay):
	if bullet == MaidBullet:
		for i in range(bullets_to_shoot):
			await shoot_timer(shoot_delay)
			var omurice = MaidBullet.instantiate()
			omurice.position = position
			if(not(player == null)):
				omurice.dir = global_position.direction_to(player.global_position)
			get_parent().add_child(omurice)
	elif bullet == MaidBullet4:
		for i in range(bullets_to_shoot):
			await shoot_timer(shoot_delay)
			var soda = MaidBullet4.instantiate()
			soda.position = position
			if(not(player == null)):
				soda.dir = global_position.direction_to(player.global_position)
			get_parent().add_child(soda)

func fight():
	rotate = MaidBullet3
	await wait_for_timer(1.5)
	speed = 100
	custom_dir(PI)
	rotational_shoot(100, 0.1, 8, 100)
	await wait_for_timer(2)
	target_bullets(5, 0.4)
	await wait_for_timer(0.9)
	rotate = MaidBullet5
	rotational_shoot(300, 0.3, 12, 100)
	await wait_for_timer(1.3)
	speed = 150
	custom_dir(0)
	await wait_for_timer(0.2)
	rotational_shoot(300, 0.3, 12, 100)
	await wait_for_timer(0.3)
	target_bullets(5, 0.4)
	await wait_for_timer(1.5)
	rotate = MaidBullet3
	rotational_shoot(100, 0.1, 8, 100)
	await wait_for_timer(0.5)
	rotate = MaidBullet5
	rotational_shoot(100, 0.1, 8, 100)
	await wait_for_timer(1.5)
	speed = 100
	custom_dir((5*PI)/6)
	await wait_for_timer(0.2)
	rotational_shoot(100, 0.1, 8, 100)
	await wait_for_timer(1)
	target_bullets(4, 0.7)
	await wait_for_timer(2)
	for i in range(3):
		await wait_for_timer(0.5)
		rotational_shoot(300, 0.2, 12, 100)
	target_bullets(3, 0.2)
	await wait_for_timer(2.5)
	$AnimatedSprite2D.play("special")
	speed = 0
	rotate = MaidBullet2
	bullet = MaidBullet4
	await wait_for_timer(0.2)
	for i in range(10):
		await wait_for_timer(0.5)
		rotational_shoot(1200, 0.2, 15, 100)
		await wait_for_timer(0.5)
		rotational_shoot(300, 0.2, 7, 100)
		if i % 2 == 1:
			target_bullets(7, 0.1)
		if i == 1:
			$AnimatedSprite2D.play("special_static")
	rotational_shoot(100, 0.1, 6, 100)
	await wait_for_timer(2)
	rotate = MaidBullet5
	rotational_shoot(300, 0.3, 8, 100)
	await wait_for_timer(1.5)
	$AnimatedSprite2D.play("default")
	rotate = MaidBullet3
	bullet = MaidBullet
	speed = 300
	custom_dir((10.8*PI)/6)
	await wait_for_timer(1.9)
	speed = 0
	await wait_for_timer(2.2)
	target_bullets(8, 0.1)
	for i in range(3):
		await wait_for_timer(0.7)
		rotational_shoot(300, 0.1, 3, 100)
	await wait_for_timer(0.5)
	rotate = MaidBullet5
	rotational_shoot(300, 0.1, 10, 100)
	await wait_for_timer(0.5)
	speed = 150
	custom_dir(0)
	await wait_for_timer(1.3)
	rotate = MaidBullet3
	rotational_shoot(300, 0.1, 8, 100)
	await wait_for_timer(0.5)
	target_bullets(5, 0.2)
	await wait_for_timer(1.6)
	speed = 0
	await wait_for_timer(0.2)
	rotate = MaidBullet5
	for i in range(10):
		await wait_for_timer(0.2)
		rotational_shoot(300, 0.1, 10, 100)
		if i == 5:
			target_bullets(5, 0.2)
	await wait_for_timer(0.5)
	speed = 750
	custom_dir(PI)
	await wait_for_timer(0.7)
	speed = 0
	await wait_for_timer(0.2)
	target_bullets(3, 0.5)
	await wait_for_timer(2)
	rotate = MaidBullet3
	rotational_shoot(300, 0.1, 8, 100)
	await wait_for_timer(0.2)
	rotate = MaidBullet5
	for i in range(3):
		await wait_for_timer(0.5)
		rotational_shoot(300, 0.1, 10, 100)
	await wait_for_timer(1.3)
	$AnimatedSprite2D.play("special")
	rotate = MaidBullet2
	bullet = MaidBullet4
	for i in range(15):
		await wait_for_timer(0.5)
		rotational_shoot(1200, 0.2, 15, 100)
		await wait_for_timer(0.5)
		rotational_shoot(300, 0.2, 7, 100)
		if i % 2 == 1:
			target_bullets(7, 0.1)
		if i == 1:
			$AnimatedSprite2D.play("special_static")
	await wait_for_timer(0.2)
	$AnimatedSprite2D.play("default")
	


func _on_area_2d_area_entered(area):
	if area.is_in_group("PB"):
		Score.score += 10
		hit.emit()


func _on_area_2d_body_entered(body):
	if body.is_in_group("PB"):
		Score.score += 10
		hit.emit()
