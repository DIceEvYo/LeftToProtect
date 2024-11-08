class_name Player extends CharacterBody2D
signal hit 
# BEN testing lol chinchin
# His method of doing this. Apparently not important. Is default direction of player(?).
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var move_speed : float = 100.0
# Temporary way to make state. Covered in next video.
var state : String = "idle"
# Size of game window
var screen_size

@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer
@onready var sprite_2d: Sprite2D = $Player/Sprite2D

#chinchin


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Finds size of game window
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Changes direction based on selected direction (set in Project Settings -> Input map.)
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# Velocity. Used by _physics_process().
	velocity = direction * move_speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# Runs if state has been changed (returned true). Updates animation selection.
	if SetState() == true || SetDirection() == true:
		UpdateAnimation()
	
	pass


# The physics part of game.
func _physics_process(delta):
	move_and_slide()
	
	
# Sets the direction the Player faces.
func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
		
	if direction.y == 0:
		# < 0 is overkill, since keyboard is always l = -1 and r = 1, but accounts for stuff besides keyboard.
		# Since direction.x can't be zero (due to checking earlier), we set new_dir to left if .x < 0, otherwise right.
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		# Since direction.y can't be zero (due to checking earlier), we set new_dir to up if .y < 0, otherwise down.
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	# Don't want to change if same direction.
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	# Sets sprite to look left or right by flipping direction. This is one way to do so.
	# The other way is to go to offset -> flip H.
	# Can also have parent-child flip together by transform -> unlink (scale) -> scale.x = -1/1.
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
	
# Sets state of Player between "idle" and "walk".
func SetState() -> bool:
	# set new_state to "idle" if no movement, else set to "walk".
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	
	# Checks if state has changed. If so, no need to update animation, therefore return false.
	if new_state == state:
		return false
		
	# If different, set state to new_state, and return true, signifying change in animation.
	state = new_state
	return true
	
	
# Plays correct animation.
func UpdateAnimation() -> void:
	# (state is temp for now) 
	# animation_player is what we want played, so we call the play() function, and it plays the 
	# specified animation, in this case being "idle_down/up/side"
	animation_player.play(state + "_" + AnimDirection())
	pass


# Function allows for dynamic change of direction.
func AnimDirection() -> String:
	# Checks if cardinal_direction equals vector for DOWN, UP, or side (not left and right because same frame, different direction.)
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
