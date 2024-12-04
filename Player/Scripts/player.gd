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
var invincible = false

########################### Player abilities.
###### 1. Shield. Blocks one hit. 5 second cooldown.
var shield_active = false
var shield_cooldown = false

###### 2. Spinning Golem bullet. Comes out spinning, every enemy bullet it hits increases its size. 
var spinning_bullet = preload("res://Player/SpinningPlayerBullet.tscn")
var spinning_bullet_cooldown = false

###### 3. Spawn Golem 'Power Rangers.' Spawn single baby golem that follows and shoots at enemy. Despawns after 15 seconds.
var golem_spawner = preload("res://Player/BabyGolem.tscn")
var golem_spawner_cooldown = false

###### 4. Heat-seeking baby-golems that blow up and do damage on contact.


# Bullet-related information. Perhaps have mode where shoot rapid fast or accurate slow.
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Changes direction based on selected direction (set in Project Settings -> Input map.)
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")


# The physics part of game.
func _physics_process(delta):
	# Shoots bullet if player presses space or LMB.
	if Input.is_action_just_pressed("shoot"):
		fire("shoot")
		
	# Activates shield if player presses E.
	if Input.is_action_just_pressed("shield"):
		shield()
		
	if Input.is_action_just_pressed("spinning_bullet"):
		fire("spinning_bullet")
		
	if Input.is_action_just_pressed("spawn_golems"):
		golem_spawn()
		
	if Input.is_action_just_pressed("heat_seeking_golems"):
		pass
		
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
	sprite_2d.scale.x = -3 if cardinal_direction == Vector2.LEFT else 3
	return true
	
	
# Plays correct animation.
func UpdateAnimation( state : String) -> void:
	# (state is temp for now) 
	# animation_player is what we want played, so we call the play() function, and it plays the 
	# specified animation, in this case being "idle_down/up/side"
	animation_player.play(state + "_" + AnimDirection())


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
func fire( attack : String ):
	var bullet_instance
	
	if attack == "shoot":
		# New regular bullet.
		bullet_instance = bullet.instantiate()
		
	elif attack == "spinning_bullet":
		if spinning_bullet_cooldown == true:
			print("Sping cooldown.")
			return
		# New spinning bullet.
		bullet_instance = spinning_bullet.instantiate()
		spinning_bullet_cooldown = true
		get_node("Spinning_Bullet_Timer").start()
	
	# Calculates direction of mouse position.
	var target_position = get_global_mouse_position()
	bullet_instance.direction = (target_position - position).normalized()
	
	# Bullet placed at player position before added to scene (check def later)
	bullet_instance.position = position
	get_parent().add_child(bullet_instance)
	
	return
	
	
######### Golem first ability. Creates sheild that blocks one attack. Destroyed afterwards. Can take 3-5 seconds to create another.
func shield() -> void:
	if shield_cooldown:
		print("Shield on cooldown.")
		return
	
	shield_active = true
	shield_cooldown = true
	print("Shield activated.")
	get_node("Shield_Cooldown_Timer").start()
	return
	
	
func _on_shield_cooldown_timer_timeout() -> void:
	# Cooldown is 5 seconds.
	shield_cooldown = false
	print("Shield ready.")
	return
	

######## Golem second ability. A spinning golem bullet is shot, and grows bigger the more enemy bullets it absorbs.
func spinning_golem_bullet() -> void:
	fire("spinning_bullet")
	return
	
	
func _on_spinning_bullet_timer_timeout() -> void:
	# Cooldown is 5 seconds.
	spinning_bullet_cooldown = false
	print("Spin ready.")
	return

	
######## Golem third ability. Spawns baby golem that moves towards enemy while shooting at them. Despawns after 15 seconds.
func golem_spawn() -> void:
	if golem_spawner_cooldown:
		print("Baby golem on cooldown.")
		return
		
	var golem = golem_spawner.instantiate()
	
	golem.position = position
	golem.direction = (golem.position - position).normalized()
	
	# Bullet placed at player position before added to scene (check def later)
	golem.position = position
	get_parent().add_child(golem)
	
	get_node("Baby_Golem_Timer").start()
	golem_spawner_cooldown = true
	return
	
	
func _on_baby_golem_timer_timeout() -> void:
	golem_spawner_cooldown = false
	print("Baby Golem ready.")
	return
	
	
######## Golem fourth ability. Heat-seekers. Several shot out and move towards enemy. On contact, blows up and damages them.
	
# Called when player is hita. Stays invincible for a bit.
func invincibility_frame() -> void:
	invincible = true
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
	return

	
# When called, kills the player and reloads the page.
func kill() -> void:
	get_tree().reload_current_scene()
	return
	
	
func take_damage() -> void:
	# Checks if invincible
	if invincible:
		return
	# Mitigate damage if has shield.
	elif shield_active:
		shield_active = false
		return
	else:
		health -= 10
		invincibility_frame()
		
	if health <= 0:
		kill()
		
	return
	


# Kills/refreshes player/scene when 'Maid' or 'bullet' object interacts with Player.
func _on_player_body_entered(body: RigidBody2D) -> void:
	if "Maid" in body.name or "bullet" in body.name:
		# Checks if invincible
		if invincible:
			return
		# Mitigate damage if has shield.
		elif shield_active:
			shield_active = false
			return
		else:
			take_damage()
			
		if health <= 0:
			kill()
		
	return
