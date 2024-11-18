class_name State_Walk extends State

# Speed moved here. Var shows up on inspector, and can be adjusted by looking at player (Under StateMachine-Walk)
@export var move_speed : float = 1000

# Reference here so that we can return different states.
@onready var idle: State = $"../Idle"
	

# Runs when entering this state. Contains what happens when entering this state.
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass
	
	
# Runs when exiting this state. Contains what happens when exiting this state.
func Exit() -> void:
	pass
	
	
# What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null
	
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float ) -> State:
	return null
	
# What happens with input events in this State?
func HandleInput( _event : InputEvent ) -> State:
	return null
