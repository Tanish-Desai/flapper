extends CharacterBody2D

const GRAVITY : int = 1000
const MAX_VEL : int = 600
const FLAP_SPEED : int = -500
var flying : bool = false
var falling : bool = false
const START_POS = Vector2(100, 400)

# Called when node enters scene tree for the first time
func _ready():
	reset()
	
func reset():
	falling = false
	flying = false
	position = START_POS
	set_rotation(0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if flying or falling:
		velocity.y += GRAVITY * delta
		# terminal velocity
		if velocity.y > MAX_VEL:
			velocity.y = MAX_VEL
		if flying:
			# QUESTION: what does the rotation below do?
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play("flying")
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()
			
		# Will detect collisions along the Vector2D object passed in it (i.e. velocity * delta)
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()
		
func flap():
	velocity.y = FLAP_SPEED
