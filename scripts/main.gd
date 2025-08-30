extends Node2D

# The @export exports the pipe_scene variable as a property of the Main scene that can be modified in the inspector panel. This helps the Main script to create parameter-like systems (here its the pipe scene), that can be used in code. In this particular example, I can create a new variant of the pipe scene (new design) and simply pass it here via the Inspector.
@export var pipe_scene : PackedScene

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : int = 4
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()

func new_game():
	# reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$Ground.hit.connect(ground_hit)
	pipes.clear() # clears pipe array, clear() is array function
	generate_pipes() # to generate first set of pipes
	$Bird.reset()

func _input(event: InputEvent) -> void:
	if !game_over:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				# the second condition in if (is_pressed()) is to make sure the event is 'press', not 'release'
				if !game_running:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()
						check_top()

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start() #start pipe timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("Time left:" + str($PipeTimer.time_left))
	if game_running:
		scroll += SCROLL_SPEED
		if scroll >= screen_size.x:
			scroll = 0
			
		# Ground position.x is relative to position that has been manually set in scene editor
		$Ground.position.x = -scroll
		# move pipes
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED

func _on_pipe_timer_timeout() -> void:
	generate_pipes()
	
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	
	# By connecting to bird_hit, if the hit signal is ever emitted from pipe, then bird_hit() will be called
	# note that the game doesn't halt here for the hit signal, it simply connects the bird_hit() function call to the hit signal i.e. bird_hit() is set to be auto-called when hit is emitted
	pipe.hit.connect(bird_hit)
	
	# add_child will add the just created pipe as a child scene to the Main scene.
	add_child(pipe)
	pipes.append(pipe) # adds the pipe to the pipes array

func bird_hit():
	$Bird.falling = true
	stop_game()
	pass #temporary pass

func ground_hit():
	$Bird.falling = false
	stop_game()

func check_top():
	# as of now, the game will end if the bird touched the ceiling.
	# TODO: Add a World Boundary for the top, and skip this function
	if $Bird.position.y < 0:
		$Bird.falling = true
		stop_game()

func stop_game():
	$Bird.flying = false # stop executing any flaps
	$PipeTimer.stop() # stops pipe generation
	game_running = false
	game_over = true # will be used later for score system and restart_game
