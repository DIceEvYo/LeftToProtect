extends RigidBody2D
#General Vars
var speed = 0
var dir = Vector2.ZERO #Resets direction to default.
var screen_size #Size of game window
var waiting = true

#Time specific Vars
var change_dir_timer = 2.0 #How many seconds it takes for direction to change
var time_elapsed = 0.0

func _ready():
	# Finds size of game window
	screen_size = get_viewport_rect().size
	randomize()
	change_dir()

func _process(delta):
	if not waiting:
		#Linear Velocity is a var specific to RigidBody2d that controls 
		#speed and direction on a given 2d plane. 
		linear_velocity = dir*speed
		#Uses delta (frame time) to calculate time elapsed
		time_elapsed += delta
		check_bounds()
		if time_elapsed > change_dir_timer:
			change_dir()
			time_elapsed = 0
		#Prevents enemy from leaving the screen.
		position = position.clamp(Vector2.ZERO, screen_size)

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
	#Makes maid wait 1 second.
	speed = 0
	dir = Vector2.ZERO
	get_node("Timer").start()
	
func _on_timer_timeout():
	speed = 100
	waiting = false
