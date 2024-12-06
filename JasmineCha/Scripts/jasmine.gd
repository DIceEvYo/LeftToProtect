extends Node2D

var speed = 2
var speed_factor = 1
var dir = Vector2.ZERO
var intro = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	attack_sequence()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += dir.y * abs(speed)
	position.x += dir.x * speed

func custom_dir(angle):
	dir = Vector2(cos(angle), sin(angle)).normalized()

func wait_for_timer(duration):
	$WaitTimer.start(duration)  #Start the timer with the specified duration
	await $WaitTimer.timeout    #Wait until the timeout signal is emitted
	
func shoot_timer(duration):
	$ShootTimer.start(duration)  #Start the timer with the specified duration
	await $ShootTimer.timeout    #Wait until the timeout signal is emitted

func attack_sequence():
	if intro:
		var timer_vals = [2,2.5,4.5,2.5,2.8]
		for i in range (0, 11):
			custom_dir(PI)
			await wait_for_timer(timer_vals[0]) 
			custom_dir(PI/2)
			await wait_for_timer(timer_vals[1]) 
			custom_dir(0)
			await wait_for_timer(timer_vals[2]) 
			custom_dir((3*PI)/2)
			await wait_for_timer(timer_vals[3])
			custom_dir(PI)
			await wait_for_timer(timer_vals[4])
			speed_factor += .5
			speed *= speed_factor
			for j in range(timer_vals.size()):
				timer_vals[j] /= speed_factor

