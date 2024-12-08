extends Node2D

const speed = 500
var rotate_speed = 100
var new_rotation = 0

@onready var rotation_st = %RotationShootTimer
@onready var rotater = %Rotater

var leaf_scene = preload("res://JasmineCha/Scenes/Bullets/leafBullet.tscn")
var itazura_flame_scene = preload("res://Ghost/Scenes/Bullets/ItazuraFlameBullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	%AnimatedSprite2D.play("default")
	set_as_top_level(true)
	rotational_shoot(1000, 0.1, 20, 100) 
	%BakudanTimer.start(1)

func rotational_shoot(set_rotate_speed, shoot_timer_wait_time, amount_to_shoot, radius):
	rotate_speed = set_rotate_speed
	var rotate_step = 2*PI/amount_to_shoot
	for i in range(0, amount_to_shoot):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(rotate_step*i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
	rotation_st.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	position += transform.x * speed * delta
	#scale += Vector2(1, 1)
	#Removes bullet when it leaves the screen.
	if !get_viewport_rect().has_point(position):
		queue_free() 

func _on_area_2d_body_entered(body):
	if body == Player:
		queue_free()

func _on_rotation_shoot_timer_timeout():
	var count = 0
	var tree := get_tree()
	for s in rotater.get_children():
		var leaf = BulletPool.leaf_pool[BulletPool.next_leaf]
		leaf.reset()
		BulletPool.next_leaf += 1
		leaf.position = position
		leaf.rotation = s.global_rotation
		if count == 1: leaf.leaf_type = "red"
		if count == 2: leaf.leaf_type = "orange"
		if count == 3: leaf.leaf_type = "yellow"
		rotater.remove_child(s)
		if count < 3: count+=1
		else: count = 0


func _on_bakudan_timer_timeout():
	var tree := get_tree()
	var itazura_flame = itazura_flame_scene.instantiate()
	tree.root.add_child(itazura_flame)
	itazura_flame.position = position
	itazura_flame.rotation = 2 * PI
	itazura_flame = itazura_flame_scene.instantiate()
	tree.root.add_child(itazura_flame)
	itazura_flame.position = position
	itazura_flame.rotation = (3 * PI)/2
	itazura_flame = itazura_flame_scene.instantiate()
	tree.root.add_child(itazura_flame)
	itazura_flame.position = position
	itazura_flame.rotation = (PI)/2
	itazura_flame = itazura_flame_scene.instantiate()
	tree.root.add_child(itazura_flame)
	itazura_flame.position = position
	itazura_flame.rotation = PI
	queue_free()
