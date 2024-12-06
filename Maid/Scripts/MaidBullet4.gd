extends Node2D

var speed = 5 #bullets go brrrr#
var dir = Vector2.ZERO

func _ready():
	#Allows bullet to leave the screen bounds.
	set_as_top_level(true)
	position.x += dir.x * speed

func _process(delta):
	position += dir * speed
	rotation = (dir.angle()-(PI/2))
	if !get_viewport_rect().has_point(position):
		queue_free()
