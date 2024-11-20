extends Node2D

const speed = 800
var GhostBullet = preload("res://Ghost/Scenes/Bullets/GravityBullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("itazura")
	$SwitchTimer.start()
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta
	#Removes bullet when it leaves the screen.
	#if !get_viewport_rect().has_point(position):
	#	queue_free()


func _on_switch_timer_timeout():
	var gbullet = GhostBullet.instantiate()
	gbullet.position = position
	gbullet.position.x = position.x
	get_parent().add_child(gbullet)
	queue_free()
