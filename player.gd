extends CharacterBody2D


@export var gravity: float = 1000  
@export var max_speed: float = 600  
@export var flap_speed : float = -500  
@export var flying : bool = false 
@export var falling : bool = false  
@export var start_position = Vector2(100, 400)  # Initial position

# Called when the game starts or player respawns
func _ready():
	reset()

# Resets player state
func reset():
	falling = false
	flying = false
	position = start_position
	set_rotation(0)  # Reset rotation

# Handles physics updates
func _physics_process(delta):
	if flying or falling:
		velocity.y += gravity * delta  # Apply gravity
		if velocity.y > max_speed:
			velocity.y = max_speed  # Cap falling speed

		# Tilts player based on movement
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
		elif falling:
			set_rotation(PI/2)  # Face downward when falling

		move_and_collide(velocity * delta)  # Apply movement

# Handles player flapping
func flap():
	velocity.y = flap_speed  # Moves player upwards

# Visual feedback for damage (flashes red)
func take_damage():
	modulate = Color(1, 0, 0)  # Change to red
	await get_tree().create_timer(0.2).timeout
	modulate = Color(1, 1, 1)  # Reset color
