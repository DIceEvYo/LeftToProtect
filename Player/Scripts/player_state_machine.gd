class_name PlayerStateMachine extends Node

"""
Player State Machine Class.
Controls all states (manager).
"""

var states : Array[ State ]
var prev_state : State
var current_state : State


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# All three functions handle all logic for states.
# Related to state.Process(delta)
func _process(delta: float) -> void:
	ChangeState( current_state.Process( delta ) )
	pass
	
	
# Related to state.Physics(delta)
func _physics_process(delta: float) -> void:
	ChangeState( current_state.Physics( delta ) )
	pass
	
	
# Related to state.HandleInput(event)
func _unhandled_input( event ):
	ChangeState( current_state.HandleInput( event ) )


func Initialize( _player : Player) -> void:
	states = []
	
	# get_children() returns all children of this node as array.
	for c in get_children():
		# Checks if c is in any way related to State (Inheritance, Extends, Instance, etc.).
		# If so, appends to array states.
		if c is State:
			states.append(c)
			
		if states.size() > 0:
			states[0].player = _player
			ChangeState( states[0] )
			process_mode = Node.PROCESS_MODE_INHERIT
		

# State machine. Core part of entire process.
func ChangeState( new_state : State) -> void:
	# Ends function if new_state is either null or unchanged.
	if new_state == null || new_state == current_state:
		return
		
	# Structured as such to prevent error on first run. 
	# Calls Exit() function of the current state to transition into new one.
	if current_state:
		current_state.Exit()

	# Saves states into respective variables and calles Enter() for new state.
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
