extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "Drop" # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if linear_velocity.y < 0:
		$AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
		queue_free()
