extends Node2D

var player_scene = preload("res://Player/player.tscn")
var jasmine_scene = load("res://JasmineCha/Scenes/jasmine.tscn")
@onready var frame_rate_label = $FrameRateLabel
var frame_rate_readings: Array[float] 

# Called when the node enters the scene tree for the first time.
func _ready():
	LeafBullet.viewport_rect = get_viewport_rect()
	var player = player_scene.instantiate()
	player.position.x = 1030
	player.position.y = 970
	add_child(player)
	var jasmine = jasmine_scene.instantiate()
	jasmine.position.x = 850
	jasmine.position.y = 350
	jasmine.intro = true
	jasmine.player = player
	var jasmine1 = jasmine_scene.instantiate()
	jasmine1.position.x = 850
	jasmine1.position.y = 350
	jasmine1.intro = true
	jasmine1.speed = -2
	add_child(jasmine)
	add_child(jasmine1)
	$BackgroundMusic.play()
	await wait_for_timer(32)
	remove_child(jasmine)
	remove_child(jasmine1)
	var jasmine2 = jasmine_scene.instantiate()
	jasmine2.position.x = 850
	jasmine2.position.y = 350
	jasmine2.player = player
	jasmine2.build_up = true
	add_child(jasmine2)
	await wait_for_timer(12)
	var angle = [0,  PI/4,  PI/2,  3*PI/4,  PI, 5*PI/4,  3*PI/2,  7*PI/4,  2*PI]
	for a in angle:
		var jasmine3 = jasmine_scene.instantiate()
		jasmine3.position.x = 960
		jasmine3.position.y = 550
		jasmine3.dir = Vector2(cos(a), sin(a)).normalized()
		jasmine3.player = player
		jasmine3.yabai = true
		add_child(jasmine3)
	await wait_for_timer(23)
	jasmine = jasmine_scene.instantiate()
	jasmine.position.x = 850
	jasmine.position.y = 350
	jasmine.end = true
	jasmine.player = player
	jasmine1 = jasmine_scene.instantiate()
	jasmine1.position.x = 850
	jasmine1.position.y = 350
	jasmine1.end = true
	jasmine1.speed = -2
	add_child(jasmine)
	add_child(jasmine1)
	await wait_for_timer(43)
	remove_child(jasmine)
	remove_child(jasmine1)
	queue_free()

func wait_for_timer(duration):
	$WaitTimer.start(duration)  #Start the timer with the specified duration
	await $WaitTimer.timeout    #Wait until the timeout signal is emitted

# only used for getting frame rate
func _physics_process(_delta):
	frame_rate_label.text = "Frame rate: " + str(Engine.get_frames_per_second())
	frame_rate_readings.append(Engine.get_frames_per_second())


func check_reading() -> void:
	var sum := 0.0
	var average: float
	var min: float
	for frame_rate in frame_rate_readings:
		sum += frame_rate
	average = sum / frame_rate_readings.size()
	min = frame_rate_readings.min()
	print("average framerate: " + str(average))
	print("lowest framerate: " + str(min))
	
	#reading without improvements
	#average: 48.6
	#min: 1
	
	#reading with leaf bullet simplified
	#average framerate: 52.8936582664082
	#lowest framerate: 1
