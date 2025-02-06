extends Node2D

var title_image = preload("res://Title Screen/title_screen.tscn")

func _ready(): 
	var title = title_image.instantiate()
	add_child(title)
	await title.tree_exited
	
