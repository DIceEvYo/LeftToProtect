extends Node2D

var revolving_background_scene = preload("res://Background/Scenes/revolving_bg.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var revolving_bg = revolving_background_scene.instantiate()
	revolving_bg.limit = 10
	add_child(revolving_bg)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
