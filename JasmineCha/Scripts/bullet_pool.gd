extends Node
class_name BulletPool


static var leaf_scene = preload("res://JasmineCha/Scenes/Bullets/leafBullet.tscn")
static var leaf_count_max := 250
static var leaf_pool: Array[LeafBullet]
static var next_leaf := 0:
	set(value):
		next_leaf = value
		if value >= leaf_count_max:
			next_leaf = 0

static func startup() -> void:
	leaf_pool.resize(leaf_count_max)
	for leaf in leaf_count_max:
		leaf_pool[leaf] = leaf_scene.instantiate()
