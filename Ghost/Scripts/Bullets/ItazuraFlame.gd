extends Node2D

const speed = 800
var dead := false
var GhostBullet = preload("res://Ghost/Scenes/Bullets/GravityBullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("itazura")
	$SwitchTimer.start()
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta


func _on_switch_timer_timeout():
	var gbullet = GhostBullet.instantiate()
	gbullet.position = position
	gbullet.position.x = position.x
	get_parent().add_child(gbullet)
	_dead()


func reset() -> void:
	if not dead:
		return
		print("increase limit")
	dead = false
	position = Vector2.ZERO
	set_process(true)
	visible = true


func _dead() -> void:
	set_process(false)
	visible = false
	dead = true
