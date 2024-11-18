extends Node2D

func _ready():
	attack_sequence()

func _process(delta):
	pass

func attack_sequence():
	#Dialogue stuff
	$AnimationPlayer.play("fade_in")
	await wait_for_timer(3.0)
	$AnimationPlayer.play("fade_out")
	await wait_for_timer(1.0)
	await wait_for_timer(0.34)
	#First attack
	$BackgroundMusic.play()
	
func wait_for_timer(duration):
	$WaitTimer.start(duration)  #Start the timer with the specified duration
	await $WaitTimer.timeout    #Wait until the timeout signal is emitted
		
