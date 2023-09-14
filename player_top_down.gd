extends CharacterBody3D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).

#var velocity := Vector2.ZERO
var velocity3 = Vector3.ZERO

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var elevation = 0
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	'''var velocity3 = Vector3.ZERO # The player's movement vector.
	if Input.is_action_pressed("walk_down"):
		velocity3.y += 1
	if Input.is_action_pressed("walk_up"):
		velocity3.y -= 1
	if Input.is_action_pressed("walk_right"):
		velocity3.x += 1
	if Input.is_action_pressed("walk_left"):
		velocity3.x -= 1
	if Input.is_action_pressed("jump"):
		velocity3.z -= 1
	
	var velocity = Vector2(velocity3.x,velocity3.y+velocity3.z)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimationPlayer.play("walk_down")

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)'''
	
func _physics_process(delta):
	
	var horizontal := 0
	
	if Input.is_action_pressed("walk_left"):
		horizontal -= 1
	if Input.is_action_pressed("walk_right"):
		horizontal += 1
	
	var vertical := 0
	
	if Input.is_action_pressed("walk_up"):
		vertical -= 1
	if Input.is_action_pressed("walk_down"):
		vertical += 1
	
	velocity.z += vertical * speed
	velocity.x = horizontal * speed
	velocity.y = get_gravity(velocity.y)
	
	move_and_slide()
	#if Input.is_action_just_pressed("jump") and is_on_floor():
	if Input.is_action_just_pressed("jump"):
			velocity3.z = jump_velocity
	

	
	move_and_slide()

func get_gravity(velocityRate) -> float:
	return jump_gravity if velocityRate < 0.0 else fall_gravity

