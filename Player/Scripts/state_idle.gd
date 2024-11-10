class_name State_Idle extends State


@onready var walk: State = $"../Walk"



# Runs when entering this state. Contains what happens when entering this state.
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass
	
	
# Runs when exiting this state. Contains what happens when exiting this state.
func Exit() -> void:
	pass
	
	
# What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	# Sets velocity to zero, since it's idle.
	player.velocity = Vector2.ZERO
	return null
	
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float ) -> State:
	return null
	
# What happens with input events in this State?
func HandleInput( _event : InputEvent ) -> State:
	return null
