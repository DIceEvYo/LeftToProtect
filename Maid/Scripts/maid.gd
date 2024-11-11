extends RigidBody2D

var MaidBullet = preload("res://Maid/MaidBullet.tscn")

#General Variables
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
	#Finds size of game window
	screen_size = get_viewport_rect().size
	randomize()
	change_dir()

func _process(delta):
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
	wait()
	#Randf generates random floating-point num between 0&1. TAU is 2π.
	#In other words angle selects a rand angle from 0 to 2π.
	var angle = randf() * TAU
	#Normalized keeps vector at length of 1 to prevent any side effects.
	dir = Vector2(cos(angle), sin(angle)).normalized()

func wait():
	waiting = true
	speed = 0
	dir = Vector2.ZERO
	#Makes maid wait 1 second.
	get_node("Timer").start()
	get_node("Timer2").start()
	
func _on_timer_timeout():
	waiting = false
	speed = 100
	
func _on_timer_2_timeout():
	if waiting:
		shoot()

func shoot():
	var bullet = MaidBullet.instantiate()
	bullet.position = position
	bullet.dir = (Vector2(0, 1)).normalized()
	get_parent().add_child(bullet)
