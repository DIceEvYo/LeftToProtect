extends Node2D

const speed = 500
var itazura_flame_scene = preload("res://Ghost/Scenes/Bullets/ItazuraFlameBullet.tscn")
var finalAnim = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$BakudanTimer.start(.2)
	$AnimatedSprite2D.play("bakudan")
	set_as_top_level(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta
	#Removes bullet when it leaves the screen.
	if !get_viewport_rect().has_point(position):
		queue_free()


func _on_bakudan_timer_timeout():
	$AnimatedSprite2D.play("bakuhatsu")
	finalAnim = true

func _on_animated_sprite_2d_animation_finished():
	if (finalAnim):
		var itazura_flame = itazura_flame_scene.instantiate()
		get_tree().root.add_child(itazura_flame)
		itazura_flame.position = position
		itazura_flame.rotation = 2 * PI
		itazura_flame = itazura_flame_scene.instantiate()
		get_tree().root.add_child(itazura_flame)
		itazura_flame.position = position
		itazura_flame.rotation = (3 * PI)/2
		itazura_flame = itazura_flame_scene.instantiate()
		get_tree().root.add_child(itazura_flame)
		itazura_flame.position = position
		itazura_flame.rotation = (PI)/2
		itazura_flame = itazura_flame_scene.instantiate()
		get_tree().root.add_child(itazura_flame)
		itazura_flame.position = position
		itazura_flame.rotation = PI
		queue_free()
