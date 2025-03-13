extends Node

@export var pipe_scene : PackedScene  # Pipe scene to be instantiated
@export var game_start : bool  
@export var game_over : bool  
@export var scroll_speed : int = 4  
@export var screen_size : Vector2i 
@export var ground_height : int 
@export var pipes : Array  
@export var pipe_delay : int = 100  # Delay between spawning pipes
@export var pipe_range : int = 200  # Range of random pipe height placement

var scroll : int  
var score  

@export var max_health: int = 3  
var health: int  

# Called when the scene starts
func _ready():
	screen_size = get_window().size  
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()  # Initializing game

# Resets the game state
func new_game():
	game_start = false
	game_over = false
	score = 0
	health = max_health  # Reset health
	scroll = 0
	$ScoreLabel.text = "SCORE: " + str(score)  # Update score display
	$GameOver.hide()  # Hide game over screen
	get_tree().call_group("pipes", "queue_free")  # Remove all pipes
	pipes.clear()
	generate_pipes()
	$Player.reset()
	update_health_ui()  # Update heart UI

# Handles player input
func _input(event):
	if not game_over:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if not game_start:
					start_game()
				else:
					if $Player.flying:
						$Player.flap()
						check_top()  # Prevent flying out of bounds

# Starts the game
func start_game():
	game_start = true
	$Player.flying = true
	$Player.flap()
	$Timer.start()  # Start pipe spawn timer

# Handles game updates
func _process(delta):
	if game_start:
		scroll += scroll_speed
		if scroll >= screen_size.x:
			scroll = 0
		$Ground.position.x = -scroll  # Moving ground for scrolling effect

		# Move pipes
		for pipe in pipes:
			pipe.position.x -= scroll_speed

# Spawns new pipes
func _on_timer_timeout():
	generate_pipes()
		
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + 100
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-pipe_range, pipe_range)
	pipe.hit.connect(player_hit)  # Connects pipe collision
	pipe.scored.connect(scored)  # Connects scoring
	add_child(pipe)
	pipes.append(pipe)

# Updates score when passing a pipe
func scored():
	score += 1
	$ScoreLabel.text = "SCORE: " + str(score)

# Prevents player from flying too high
func check_top():
	if $Player.position.y < 0:
		$Player.falling = true
		stop_game()

# Stops the game
func stop_game():
	$Timer.stop()
	$GameOver.show()
	$Player.flying = false
	game_start = false
	game_over = true

# Handles player collision with hazards (pipes)
func player_hit():
	health -= 1  # Reduce health
	update_health_ui()  # Update UI
	
	if health <= 0:
		$Player.falling = true
		stop_game()  # End game if no health left
	else:
		$Player.take_damage()  # Flash red effect

# Handles ground collision
func _on_ground_hit():
	$Player.falling = false
	stop_game()

# Restarts the game when the restart button is clicked
func _on_game_over_restart():
	new_game()

# Updates heart UI based on remaining health
func update_health_ui():
	for i in range(3):
		var heart = $HealthUI.get_child(i)
		heart.visible = i < health  # Show only hearts that match current health
