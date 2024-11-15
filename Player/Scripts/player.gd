class_name Player extends CharacterBody2D
signal hit 
# BEN testing lol chinchin
# His method of doing this. Apparently not important. Is default direction of player(?).
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

# Size of game window
var screen_size

# Player stats
var health = 50
var shield_active = false
var invincible = false

# Bullet-related information perhaps
var bullet_speed : int = 1000
var bullet = preload("res://Player/bullet.tscn")

@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer
@onready var sprite_2d: Sprite2D = $Player/Sprite2D
@onready var state_machine: PlayerStateMachine = $Player/StateMachine

#gehenners


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.Initialize(self)
	# Finds size of game window
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Changes direction based on selected direction (set in Project Settings -> Input map.)
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	pass


# The physics part of game.
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		fire()
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
	
	
# Plays correct animation.
func UpdateAnimation( state : String) -> void:
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


# Player shoots. Sends projectile.
func fire():
	# New bullet
	var bullet_instance = bullet.instantiate()
	
	# Calculates direction of mouse position.
	var target_position = get_global_mouse_position()
	bullet_instance.direction = (target_position - position).normalized()
	
	# Bullet placed at player position before added to scene (check def later)
	bullet_instance.position = position
	get_parent().add_child(bullet_instance)
	
	
# Golem second ability. Creates sheild that blocks one attack. Destroyed afterwards. Can take 3-5 seconds to create another.
func shield() -> void:
	pass
	
	
# Called when player is hita. Stays invincible for a bit.
func invincibility_frame() -> void:
	invincible = true
	print("Enter")
	get_node("Invincible_Frame_Timer").start()
	
	# Flashes for duration of invincibility.
	for flash in range(10): 
		$Player/Sprite2D.visible = false
		await get_tree().create_timer(0.1).timeout  # Wait briefly
		$Player/Sprite2D.visible = true
		await get_tree().create_timer(0.1).timeout  # Wait briefly
		$Player/Sprite2D.visible = false
		await get_tree().create_timer(0.1).timeout  # Wait briefly
		$Player/Sprite2D.visible = true

	return
	
	
# Timer for invincible frame. Sets to false at end
func _on_invincible_frame_timer_timeout() -> void:
	# Maybe display different sprite.
	invincible = false
	print("Exit")
	return

	
# When called, kills the player and reloads the page.
func kill() -> void:
	get_tree().reload_current_scene()
	return


# Kills/refreshes player/scene when 'Maid' or 'bullet' object interacts with Player.
func _on_player_body_entered(body: Node2D) -> void:
	if "Maid" in body.name or "bullet" in body.name:
		# Checks if invincible
		if invincible:
			return
		# Mitigate damage if has shield.
		elif shield_active:
			return
		
		# Reduce health.
		health -= 10
		invincibility_frame()
		
	if health <= 0:
		
		kill()
	
	return
