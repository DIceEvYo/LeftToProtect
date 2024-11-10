class_name State extends Node

"""
State Class.
Interface/blueprint for future states.
All child states will contain these methods.
"""

# static allows variable to be shared amongst all instances of itself.
# Stores a reference to the player that this state belongs to.
static var player : Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Runs when entering this state. Contains what happens when entering this state.
func Enter() -> void:
	pass
	
	
# Runs when exiting this state. Contains what happens when exiting this state.
func Exit() -> void:
	pass
	
	
# What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	return null
	
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float ) -> State:
	return null
	
# What happens with input events in this State?
func HandleInput( _event : InputEvent ) -> State:
	return null
