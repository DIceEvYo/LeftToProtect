extends RigidBody2D

var GhostBullet = preload("res://Ghost/Scenes/GhostBullet.tscn")

#General Variables
var speed = 0
var dir = Vector2.ZERO #Resets direction to default
var screen_size #Size of game window
var waiting = true
var angle = 0
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

func _process(delta):
	linear_velocity = dir * speed
	#print(position.y)
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
	#Dialogue stuff
	#$AnimationPlayer.play("fade_in")
	await wait_for_timer(3.0)
	#$AnimationPlayer.play("fade_out")
	await wait_for_timer(1.0)
	#Ghost initializes her position
	speed = 2400
	custom_dir(0)
	await wait_for_timer(0.34)
	#First attack
	#$BackgroundMusic.play()
	speed = 0
	danmaku(4, .05)
	await wait_for_timer(0.25)
	#Move to center (2nd position)
	speed = 2400
	custom_dir(PI)
	await wait_for_timer(0.68)
	#Second Attack
	speed = 0
	danmaku(4, .05)
	await wait_for_timer(0.25)
	#Move to left (3rd position)
	speed = 2400
	custom_dir((PI)/11)
	await wait_for_timer(0.34)
	#Third Attack
	speed = 0
	await wait_for_timer(.25)
	#Move down (4th position)
	speed = 2400
	custom_dir((PI)/2)
	await wait_for_timer(.28)
	#Fourth Attack
	speed = 0
	await wait_for_timer(.25)
	#Move up (before main set) As the ghost moves up, display attack illustration
	speed = 800
	custom_dir((3*PI)/2)
	await wait_for_timer(.5)
	speed = 600
	await wait_for_timer(.8)
	speed = 0
	
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
		

func shoot(pos_offset):
	var gbullet = GhostBullet.instantiate()
	gbullet.position = position
	gbullet.position.x = position.x + pos_offset
	gbullet.dir = (Vector2(0, 1)).normalized()
	get_parent().add_child(gbullet)

func umbrellaShot():
	pass

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
