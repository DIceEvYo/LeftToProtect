extends Node2D

var speed = 2
var speed_factor = 1
var dir = Vector2.ZERO
var intro = false
var rotate_speed = 100
var new_rotation = 0
var bullet_type = "green&blue"
var bullet_type2 = "target"
var green_blue_toggle = true

var player = null

@onready var rotation_st = $RotationShootTimer
@onready var rotation_st2 = $RotationShootTimer2
@onready var rotater = $Rotater

#Bullets
var blue_scene = preload("res://JasmineCha/Scenes/Bullets/blue.tscn")
var green_scene = preload("res://JasmineCha/Scenes/Bullets/green.tscn")
var flower_scene = preload("res://JasmineCha/Scenes/Bullets/flower.tscn")
var thorn_scene = preload("res://JasmineCha/Scenes/Bullets/thorn.tscn")
var target_leaf_scene = preload("res://JasmineCha/Scenes/Bullets/target_leaf.tscn")
var purple_scene = preload("res://JasmineCha/Scenes/Bullets/reverse_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	attack_sequence()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += dir.y * abs(speed)
	position.x += dir.x * speed
	new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

func custom_dir(angle):
	dir = Vector2(cos(angle), sin(angle)).normalized()

func wait_for_timer(duration):
	$WaitTimer.start(duration)  #Start the timer with the specified duration
	await $WaitTimer.timeout    #Wait until the timeout signal is emitted
	
func shoot_timer(duration):
	$ShootTimer.start(duration)  #Start the timer with the specified duration
	await $ShootTimer.timeout    #Wait until the timeout signal is emitted

func rotational_shoot(mode, set_rotate_speed, shoot_timer_wait_time, amount_to_shoot, radius):
	bullet_type = mode
	rotate_speed = set_rotate_speed
	var rotate_step = 2*PI/amount_to_shoot
	for i in range(0, amount_to_shoot):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(rotate_step*i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
	rotation_st.wait_time = rotation_st.wait_time
	rotation_st.start()
	rotation_st.timeout
	
func rotational_shoot2(mode, set_rotate_speed, shoot_timer_wait_time, amount_to_shoot, radius):
	bullet_type2 = mode
	rotate_speed = set_rotate_speed
	var rotate_step = 2*PI/amount_to_shoot
	for i in range(0, amount_to_shoot):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(rotate_step*i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
	rotation_st2.wait_time = rotation_st2.wait_time
	rotation_st2.start()
	rotation_st2.timeout	

func _on_rotation_shoot_timer_timeout():
	for s in rotater.get_children():
		if(bullet_type == "green&blue"):
			if (green_blue_toggle):
				var blue = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
			else:
				var green = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
			green_blue_toggle = !green_blue_toggle
		if(bullet_type == "flower"):
			var flower = flower_scene.instantiate()
			get_tree().root.add_child(flower)
			flower.position = position
			flower.rotation = s.global_rotation
		if(bullet_type == "blue"):
			var blue = blue_scene.instantiate()
			get_tree().root.add_child(blue)
			blue.position = position
			blue.rotation = s.global_rotation
		if(bullet_type == "green"):
			var green = green_scene.instantiate()
			get_tree().root.add_child(green)
			green.position = position
			green.rotation = s.global_rotation
		if(bullet_type == "purple"):
			var purple = purple_scene.instantiate()
			get_tree().root.add_child(purple)
			purple.position = position
			purple.rotation = s.global_rotation
		if(bullet_type == "target"):
			var target_leaf = target_leaf_scene.instantiate()
			target_leaf.position = position
			target_leaf.direction = global_position.direction_to(player.global_position)
			await shoot_timer(.1)
			get_tree().root.add_child(target_leaf)
		if(bullet_type == "green&blueburst"):
			var blue1 = blue_scene.instantiate()
			get_tree().root.add_child(blue1)
			blue1.position = position
			blue1.rotation = s.global_rotation
			await shoot_timer(.05)
			if (green_blue_toggle):
				var blue = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
				await shoot_timer(.05)
				var green = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
			else:
				var green = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
				await shoot_timer(.05)
				var blue = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
			await shoot_timer(.05)
			var green1 = green_scene.instantiate()
			get_tree().root.add_child(green1)
			green1.position = position
			green1.rotation = s.global_rotation
			green_blue_toggle = !green_blue_toggle
		rotater.remove_child(s)

func _on_rotation_shoot_timer_2_timeout():
	for s in rotater.get_children():
		if(bullet_type2 == "green&blue"):
			if (green_blue_toggle):
				var blue = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
			else:
				var green = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
			green_blue_toggle = !green_blue_toggle
		if(bullet_type2 == "purple"):
			var purple = purple_scene.instantiate()
			get_tree().root.add_child(purple)
			purple.position = position
			purple.rotation = s.global_rotation
		if(bullet_type2 == "flower"):
			var flower = flower_scene.instantiate()
			get_tree().root.add_child(flower)
			flower.position = position
			flower.rotation = s.global_rotation
		if(bullet_type2 == "blue"):
			var blue = blue_scene.instantiate()
			get_tree().root.add_child(blue)
			blue.position = position
			blue.rotation = s.global_rotation
		if(bullet_type2 == "green"):
			var green = green_scene.instantiate()
			get_tree().root.add_child(green)
			green.position = position
			green.rotation = s.global_rotation
		if(bullet_type2 == "target"):
			var target_leaf = target_leaf_scene.instantiate()
			target_leaf.position = position
			target_leaf.direction = global_position.direction_to(player.global_position)
			await shoot_timer(.1)
			get_tree().root.add_child(target_leaf)
		if(bullet_type2 == "green&blueburst"):
			var blue1 = blue_scene.instantiate()
			get_tree().root.add_child(blue1)
			blue1.position = position
			blue1.rotation = s.global_rotation
			await shoot_timer(.05)
			if (green_blue_toggle):
				var blue = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
				await shoot_timer(.05)
				var green = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
			else:
				var green = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
				await shoot_timer(.05)
				var blue = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
			await shoot_timer(.05)
			var green1 = green_scene.instantiate()
			get_tree().root.add_child(green1)
			green1.position = position
			green1.rotation = s.global_rotation
			green_blue_toggle = !green_blue_toggle
		rotater.remove_child(s)


		
func rain_shot(bullets_to_shoot, shoot_delay, pos_offset):
	for i in range(0, bullets_to_shoot):
		await shoot_timer(shoot_delay)
		var thorn = thorn_scene.instantiate()
		thorn.position = position
		thorn.position.x = position.x+pos_offset
		thorn.rotation = (PI)/2
		add_child(thorn)

func star_shot(bullets_to_shoot, shoot_delay, pos_offset):
	for i in range(0, bullets_to_shoot):
		await shoot_timer(shoot_delay)
		var angle = [0, PI/6, PI/4, PI/3, PI/2, 2*PI/3, 3*PI/4, 5*PI/6, PI, 7*PI/6, 5*PI/4, 4*PI/3, 3*PI/2, 5*PI/3, 7*PI/4, 11*PI/6, 2*PI]
		for a in angle:
			var thorn = thorn_scene.instantiate()
			thorn.position = position
			thorn.position.x = position.x+pos_offset
			thorn.rotation = a
			add_child(thorn)

func attack_sequence():
	if intro:
		var timer_vals = [2,2.5,4.5,2.5,2.8]
		var amount_to_shoot = 10
		var time_to_shoot = 0.4
		var mode = "green&blue"
		for i in range (0, 11):
			if i==1: mode = "green&blueburst"
			if i==2: 
				mode = "flower"
				amount_to_shoot = 10
			rotational_shoot(mode, 100, time_to_shoot, amount_to_shoot, 100)	
			custom_dir(PI)
			await wait_for_timer(timer_vals[0]) 
			if i==2: 
				mode = "flower"
				amount_to_shoot = 20
			rotational_shoot(mode, 100, time_to_shoot, amount_to_shoot, 100)	
			custom_dir(PI/2)
			await wait_for_timer(timer_vals[1]) 
			if i==2: 
				mode = "flower"
				amount_to_shoot = 30
			rotational_shoot(mode, 100, time_to_shoot, amount_to_shoot, 100)	
			custom_dir(0)
			await wait_for_timer(timer_vals[2]) 
			if i==2: 
				mode = "flower"
				amount_to_shoot = 40
			rotational_shoot(mode, 100, time_to_shoot, amount_to_shoot, 100)	
			custom_dir((3*PI)/2)
			await wait_for_timer(timer_vals[3])
			rotational_shoot("green&blue", 100, time_to_shoot, amount_to_shoot, 100)	
			custom_dir(PI)
			await wait_for_timer(timer_vals[4])
			speed_factor += .3
			time_to_shoot -= 0.05
			amount_to_shoot *= 2
			speed *= speed_factor
			for j in range(timer_vals.size()):
				timer_vals[j] /= speed_factor
	else:
		star_shot(50, 0.1, 0)
		await wait_for_timer(0.5)
		custom_dir(PI)
		speed = 10
		await wait_for_timer(0.5)
		speed = 0
		rotational_shoot2("target", 100, 0.1, 30, 50)
		rotational_shoot("blue", 100, 0.1, 30, 50)
		await wait_for_timer(1)
		rotational_shoot("green", 100, 0.1, 30, 100)
		await wait_for_timer(0.5)
		custom_dir(0)
		speed = 10
		await wait_for_timer(1)
		speed = 0
		rotational_shoot2("target", 100, 0.1, 20, 50)
		rotational_shoot("blue", 100, 0.1, 30, 50)
		await wait_for_timer(1)
		rotational_shoot("green", 100, 0.1, 30, 100)
		await wait_for_timer(0.2)
		position.x = 200
		await wait_for_timer(0.2)
		position.x = 850
		position.y = 350
		star_shot(50, 0.1, 0)
		await wait_for_timer(0.5)
		custom_dir(PI)
		speed = 10
		await wait_for_timer(0.5)
		speed = 0
		rotational_shoot2("target", 100, 0.1, 30, 50)
		rotational_shoot("blue", 100, 0.1, 30, 50)
		await wait_for_timer(1)
		rotational_shoot("green", 100, 0.1, 30, 100)
		await wait_for_timer(0.5)
		custom_dir(0)
		speed = 10
		await wait_for_timer(1)
		speed = 0
		rotational_shoot2("target", 100, 0.1, 10, 50)
		rotational_shoot("blue", 100, 0.1, 30, 50)
		await wait_for_timer(1)
		rotational_shoot("green", 100, 0.1, 30, 100)
		await wait_for_timer(1)
		position.x = 200
		await wait_for_timer(0.1)
		position.x = 800
		await wait_for_timer(0.1)
		position.x = 500
		await wait_for_timer(0.1)
		position.y = 500
		await wait_for_timer(0.1)
		position.x = 200
		position.y = 800
		await wait_for_timer(.1)
		position.x = 1000
		position.y = 300
		await wait_for_timer(0.1)
		position.x = 1500
		position.y = 800
		await wait_for_timer(0.1)
		position.x = 1300
		position.y = 100
		await wait_for_timer(0.1)
		position.x = 300
		position.y = 500
		await wait_for_timer(0.1)
		position.x = 1200
		position.y = 800
		await wait_for_timer(0.1)
		position.x = 850
		position.y = 350
		rotational_shoot("purple", 100, 0.1, 30, 30)
		
		



