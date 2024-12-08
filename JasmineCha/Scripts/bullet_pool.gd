extends Node2D
class_name BulletPool


static var leaf_scene = preload("res://JasmineCha/Scenes/Bullets/leafBullet.tscn")
static var itazura_flame_scene = preload("res://Ghost/Scenes/Bullets/ItazuraFlameBullet.tscn")
static var leaf_count_max := 250
static var itazura_flame_max := 400
static var leaf_pool: Array[LeafBullet]
static var itazura_flame_pool: Array[Node2D]
static var next_leaf := 0:
	set(value):
		next_leaf = value
		if value >= leaf_count_max:
			next_leaf = 0
static var next_itazura_flame := 0:
	set(value):
		next_itazura_flame = value
		if value >= itazura_flame_max:
			next_itazura_flame = 0


func _ready() -> void:
	LeafBullet.viewport_rect = get_viewport_rect()
	
	leaf_pool.resize(leaf_count_max)
	itazura_flame_pool.resize(itazura_flame_max)
	for leaf in leaf_count_max:
		leaf_pool[leaf] = leaf_scene.instantiate()
		add_child(leaf_pool[leaf])
	for itazura_flame in itazura_flame_max:
		itazura_flame_pool[itazura_flame] = itazura_flame_scene.instantiate()
		add_child(itazura_flame_pool[itazura_flame])
