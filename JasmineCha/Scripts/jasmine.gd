extends Area2D

signal hit

var speed: float = 2
var speed_factor: float = 1
var dir := Vector2.ZERO
var intro := false
var build_up := false
var yabai := false
var end := false
var rotate_speed: float = 100
var rotate_me := false
var jas_rotate_speed: float = 100
var new_rotation: float = 0
var bullet_type := "green&blue"
var bullet_type2 := "target"
var green_blue_toggle := true
var del: float = 0
var a: float = dir.angle()
var center := Vector2(960, 550)
var radius: float = 100

var sequence: Array = []
var time: int # each incremenet is 0.05 aka 1/20th a sec

var player: CharacterBody2D

@onready var rotation_st: Timer = $RotationShootTimer
@onready var rotation_st2: Timer = $RotationShootTimer2
@onready var rotater: Node2D = $Rotater

#Bullets
var blue_scene: PackedScene = preload("res://JasmineCha/Scenes/Bullets/blueBullet.tscn")
var green_scene: PackedScene = preload("res://JasmineCha/Scenes/Bullets/greenBullet.tscn")
var flower_scene: PackedScene = preload("res://JasmineCha/Scenes/Bullets/flowerBullet.tscn")
var thorn_scene: PackedScene = preload("res://JasmineCha/Scenes/Bullets/thornBullet.tscn")
var target_leaf_scene: PackedScene = preload("res://JasmineCha/Scenes/Bullets/target_leafBullet.tscn")
var purple_scene: PackedScene = preload("res://JasmineCha/Scenes/Bullets/reverseBullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sequence.resize(3000) # 150 seconds
	$AnimatedSprite2D.play("idle")
	attack_sequence()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)
	if rotate_me: 
		a += jas_rotate_speed * delta
		a = fmod(a, TAU)
		dir = Vector2(cos(a), sin(a)).normalized()
		position = center + dir * radius
	else:
		position.y += dir.y * abs(speed)
		position.x += dir.x * speed

func custom_dir(angle: float) -> void:
	dir = Vector2(cos(angle), sin(angle)).normalized()

func wait_for_timer(duration: float) -> void:
	$WaitTimer.start(duration)  #Start the timer with the specified duration
	await $WaitTimer.timeout    #Wait until the timeout signal is emitted
	
func shoot_timer(duration: float) -> void:
	$ShootTimer.start(duration)  #Start the timer with the specified duration
	await $ShootTimer.timeout    #Wait until the timeout signal is emitted

func rotational_shoot(mode: String, set_rotate_speed: float, amount_to_shoot: int) -> void:
	bullet_type = mode
	rotate_speed = set_rotate_speed
	var rotate_step: float = 2*PI/amount_to_shoot
	for i in range(0, amount_to_shoot):
		var spawn_point := Node2D.new()
		var pos := Vector2(radius, 0).rotated(rotate_step*i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
	
	rotation_st.start()


func rotational_shoot2(mode: String, set_rotate_speed: float, amount_to_shoot: int) -> void:
	bullet_type2 = mode
	rotate_speed = set_rotate_speed
	var rotate_step: float = 2*PI/amount_to_shoot
	for i in range(0, amount_to_shoot):
		var spawn_point := Node2D.new()
		var pos := Vector2(radius, 0).rotated(rotate_step*i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
	
	rotation_st2.start()

func _on_rotation_shoot_timer_timeout() -> void:
	for s in rotater.get_children():
		if(bullet_type == "green&blue"):
			if (green_blue_toggle):
				var blue: Node2D = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
			else:
				var green: Node2D = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
			green_blue_toggle = !green_blue_toggle
		
		if(bullet_type == "flower"):
			var flower: Node2D = flower_scene.instantiate()
			get_tree().root.add_child(flower)
			flower.position = position
			flower.rotation = s.global_rotation
		
		if(bullet_type == "blue"):
			var blue: Node2D = blue_scene.instantiate()
			get_tree().root.add_child(blue)
			blue.position = position
			blue.rotation = s.global_rotation
		
		if(bullet_type == "green"):
			var green: Node2D = green_scene.instantiate()
			get_tree().root.add_child(green)
			green.position = position
			green.rotation = s.global_rotation
		
		if(bullet_type == "purple"):
			var purple: Node2D = purple_scene.instantiate()
			get_tree().root.add_child(purple)
			purple.position = position
			purple.rotation = s.global_rotation
		
		if(bullet_type == "target"):
			var target_leaf: Node2D = target_leaf_scene.instantiate()
			target_leaf.position = position
			if(player):
				target_leaf.direction = global_position.direction_to(player.global_position)
			await shoot_timer(.1)
			get_tree().root.add_child(target_leaf)
		
		if(bullet_type == "green&blueburst"):
			var blue1: Node2D = blue_scene.instantiate()
			get_tree().root.add_child(blue1)
			blue1.position = position
			blue1.rotation = s.global_rotation
			await shoot_timer(.05)
			if (green_blue_toggle):
				var blue: Node2D = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
				await shoot_timer(.05)
				var green: Node2D = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
			else:
				var green: Node2D = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
				await shoot_timer(.05)
				var blue: Node2D = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
			await shoot_timer(.05)
			var green1: Node2D = green_scene.instantiate()
			get_tree().root.add_child(green1)
			green1.position = position
			green1.rotation = s.global_rotation
			green_blue_toggle = !green_blue_toggle
		
		rotater.remove_child(s)

func _on_rotation_shoot_timer_2_timeout() -> void:
	for s in rotater.get_children():
		if(bullet_type2 == "green&blue"):
			if (green_blue_toggle):
				var blue: Node2D = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
			else:
				var green: Node2D = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
			green_blue_toggle = !green_blue_toggle
		if(bullet_type2 == "purple"):
			var purple: Node2D = purple_scene.instantiate()
			get_tree().root.add_child(purple)
			purple.position = position
			purple.rotation = s.global_rotation
		if(bullet_type2 == "flower"):
			var flower: Node2D = flower_scene.instantiate()
			get_tree().root.add_child(flower)
			flower.position = position
			flower.rotation = s.global_rotation
		if(bullet_type2 == "blue"):
			var blue: Node2D = blue_scene.instantiate()
			get_tree().root.add_child(blue)
			blue.position = position
			blue.rotation = s.global_rotation
		if(bullet_type2 == "green"):
			var green: Node2D = green_scene.instantiate()
			get_tree().root.add_child(green)
			green.position = position
			green.rotation = s.global_rotation
		if(bullet_type2 == "target"):
			var target_leaf: Node2D = target_leaf_scene.instantiate()
			target_leaf.position = position
			if(player):
				target_leaf.direction = global_position.direction_to(player.global_position)
			await shoot_timer(.1)
			get_tree().root.add_child(target_leaf)
		if(bullet_type2 == "green&blueburst"):
			var blue1: Node2D = blue_scene.instantiate()
			get_tree().root.add_child(blue1)
			blue1.position = position
			blue1.rotation = s.global_rotation
			await shoot_timer(.05)
			if (green_blue_toggle):
				var blue: Node2D = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
				await shoot_timer(.05)
				var green: Node2D = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
			else:
				var green: Node2D = green_scene.instantiate()
				get_tree().root.add_child(green)
				green.position = position
				green.rotation = s.global_rotation
				await shoot_timer(.05)
				var blue: Node2D = blue_scene.instantiate()
				get_tree().root.add_child(blue)
				blue.position = position
				blue.rotation = s.global_rotation
			await shoot_timer(.05)
			var green1: Node2D = green_scene.instantiate()
			get_tree().root.add_child(green1)
			green1.position = position
			green1.rotation = s.global_rotation
			green_blue_toggle = !green_blue_toggle
		rotater.remove_child(s)


# this literally doesn't get called
#func rain_shot(bullets_to_shoot: int, shoot_delay: float, pos_offset: float) -> void:
	#for i in range(0, bullets_to_shoot):
		#await shoot_timer(shoot_delay)
		#print("is this correct")
		#var thorn: Node2D = thorn_scene.instantiate()
		#thorn.position = position
		#thorn.position.x = position.x+pos_offset
		#thorn.rotation = (PI)/2
		#add_child(thorn)

func star_shot(bullets_to_shoot: int, shoot_delay: float, pos_offset: float) -> void:
	for i in range(0, bullets_to_shoot):
		await shoot_timer(shoot_delay)
		var angle: Array[float] = [0, PI/6, PI/4, PI/3, PI/2, 2*PI/3, 3*PI/4, 5*PI/6, PI, 7*PI/6, 5*PI/4, 4*PI/3, 3*PI/2, 5*PI/3, 7*PI/4, 11*PI/6, 2*PI]
		for an in angle:
			var thorn: Node2D = thorn_scene.instantiate()
			thorn.position = position
			thorn.position.x = position.x+pos_offset
			thorn.rotation = an
			add_child(thorn)

func attack_sequence() -> void:
	if intro:
		var timer_vals: Array[float] = [2,2.5,4.5,2.5,2.8]
		var amount_to_shoot: int = 10
		var mode := "green&blue"
		for i in range (0, 11):
			if i==1: mode = "green&blueburst"
			if i==2: 
				mode = "flower"
				amount_to_shoot = 10
			rotational_shoot(mode, 100, amount_to_shoot)
			custom_dir(PI)
			await wait_for_timer(timer_vals[0]) 
			if i==2: 
				mode = "flower"
				amount_to_shoot = 20
			rotational_shoot(mode, 100, amount_to_shoot)
			custom_dir(PI/2)
			await wait_for_timer(timer_vals[1]) 
			if i==2: 
				mode = "flower"
				amount_to_shoot = 30
			rotational_shoot(mode, 100, amount_to_shoot)
			custom_dir(0)
			await wait_for_timer(timer_vals[2]) 
			if i==2: 
				mode = "flower"
				amount_to_shoot = 40
			rotational_shoot(mode, 100, amount_to_shoot)
			custom_dir((3*PI)/2)
			await wait_for_timer(timer_vals[3])
			rotational_shoot("green&blue", 100, amount_to_shoot)
			custom_dir(PI)
			await wait_for_timer(timer_vals[4])
			speed_factor += .3
			amount_to_shoot *= 2
			speed *= speed_factor
			for j in range(timer_vals.size()):
				timer_vals[j] /= speed_factor
	elif build_up:
		star_shot(50, 0.1, 0)
		await wait_for_timer(0.5)
		custom_dir(PI)
		speed = 10
		await wait_for_timer(0.5)
		speed = 0
		rotational_shoot2("target", 100, 30)
		rotational_shoot("blue", 100, 30)
		await wait_for_timer(1)
		rotational_shoot("green", 100, 30)
		await wait_for_timer(0.5)
		custom_dir(0)
		speed = 10
		await wait_for_timer(1)
		speed = 0
		rotational_shoot2("target", 100, 20)
		rotational_shoot("blue", 100, 30)
		await wait_for_timer(1)
		rotational_shoot("green", 100, 30)
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
		rotational_shoot2("target", 100, 30)
		rotational_shoot("blue", 100, 30)
		await wait_for_timer(1)
		rotational_shoot("green", 100, 30)
		await wait_for_timer(0.5)
		custom_dir(0)
		speed = 10
		await wait_for_timer(1)
		speed = 0
		rotational_shoot2("target", 100, 10)
		rotational_shoot("blue", 100, 30)
		await wait_for_timer(1)
		rotational_shoot("green", 100, 30)
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
		queue_free()
	
	elif yabai:
		speed = 10
		await wait_for_timer(.4)
		rotational_shoot("purple", 100, 10)
		speed = 0
		await wait_for_timer(.1)
		a = dir.angle()
		jas_rotate_speed = 2
		radius = 500
		rotate_me = true
		rotational_shoot("green&blueburst", 100, 10)
		await wait_for_timer(.3)
		rotational_shoot("purple", 100, 10)
		rotational_shoot2("target", 100, 10)
		jas_rotate_speed = -2
		await wait_for_timer(.3)
		rotational_shoot("green&blueburst", 100, 10)
		jas_rotate_speed = -3
		await wait_for_timer(.3)
		rotational_shoot("blue", 100, 10)
		star_shot(1, 0.1, 0)
		jas_rotate_speed = 3
		await wait_for_timer(.5)
		jas_rotate_speed = -4
		await wait_for_timer(.5)
		jas_rotate_speed = 5
		rotational_shoot("flower", 100, 10)
		await wait_for_timer(.5)
		jas_rotate_speed = 6
		rotational_shoot("blue", 100, 10)
		await wait_for_timer(.5)
		jas_rotate_speed = 7
		rotational_shoot("green", 100, 10)
		await wait_for_timer(.5)
		jas_rotate_speed = 8
		rotational_shoot("green", 100, 10)
		await wait_for_timer(.5)
		jas_rotate_speed = 8
		rotational_shoot2("target", 100, 10)
		rotational_shoot("purple", 100, 10)
		await wait_for_timer(.5)
		jas_rotate_speed += 1
		rotational_shoot("flower", 100, 10)
		await wait_for_timer(3)
		star_shot(1, 0.1, 0)
		await wait_for_timer(.5)
		jas_rotate_speed += 5
		rotational_shoot2("target", 100, 10)
		rotational_shoot("purple", 100, 10)
		await wait_for_timer(4)
		jas_rotate_speed += 100
		rotational_shoot("green&blueburst", 100, 10)
		rotational_shoot2("target", 100, 10)
		await wait_for_timer(2)
		star_shot(2, 0.1, 0)
		rotational_shoot("flower", 100, 10)
		rotational_shoot2("target", 100, 10)
		await wait_for_timer(1)
		rotate_me = false
		speed = 3
		await wait_for_timer(3)
		queue_free()
	if end:
		var timer_vals: Array[float] = [2,2.5,4.5,2.5,2.8]
		var amount_to_shoot: int = 10
		var mode := "green&blue"
		for i in range (0, 5):
			if i==1: mode = "green&blueburst"
			if i==2: 
				mode = "flower"
				amount_to_shoot = 10
			if i > 2: mode = "blue"
			rotational_shoot(mode, 100, amount_to_shoot)
			custom_dir(PI)
			await wait_for_timer(timer_vals[0]) 
			rotational_shoot(mode, 100, amount_to_shoot)
			custom_dir(PI/2)
			await wait_for_timer(timer_vals[1]) 
			rotational_shoot(mode, 100, amount_to_shoot)
			custom_dir(0)
			await wait_for_timer(timer_vals[2]) 
			if i==2: 
				mode = "flower"
				amount_to_shoot = 20
			rotational_shoot(mode, 100, amount_to_shoot)
			custom_dir((3*PI)/2)
			await wait_for_timer(timer_vals[3])
			rotational_shoot("green&blue", 100, amount_to_shoot)
			custom_dir(PI)
			await wait_for_timer(timer_vals[4])
			if i < 3:
				speed_factor += .3
			else:
				speed_factor -= .3
			amount_to_shoot += 5
			if i < 3:
				speed *= speed_factor
			else:
				speed -= .6
			for j in range(timer_vals.size()):
				timer_vals[j] /= speed_factor

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("PB"):
		Score.score += 10
		hit.emit()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("PB"):
		Score.score += 10
		hit.emit()
