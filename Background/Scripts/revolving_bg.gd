extends Node2D

var bg_scene = preload("res://Background/Scenes/static_bg.tscn")
var bg = bg_scene.instantiate()
var bg1 = bg_scene.instantiate()
var limit = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	bg.position.x = 960
	bg.position.y = -572
	add_child(bg)
	bg1.position.x = 960
	bg1.position.y = bg.position.y - 2746
	add_child(bg)
	add_child(bg1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	while limit > 0:
		if bg.tree_exited:
			limit-= 1
			bg = bg_scene.instantiate()
			bg.position.x = 960
			bg.position.y = bg1.position.y - 2746
			add_child(bg)
		if bg1.tree_exited:
			limit-= 1
			bg1 = bg_scene.instantiate()
			bg1.position.x = 960
			bg1.position.y = bg.position.y - 2746
			add_child(bg1)
