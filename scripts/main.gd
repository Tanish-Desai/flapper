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
	new_game()

func new_game():
	# reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
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

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		scroll += SCROLL_SPEED
		if scroll >= screen_size.x:
			scroll = 0
		# Ground position.x is relative to position that has been manually set in scene editor
		$Ground.position.x = -scroll
