extends CharacterBody2D

signal revive

@export var speed = 40
var disabled = false: set = set_disabled
var velocity = Vector2.ZERO

@onready var life_bar:TextureProgressBar = $Pivot/LifeBar
@onready var tween:Tween = $Tween
@onready var sprite = $Pivot/Sprite2D
@onready var start_pos = global_position


func hit(damage):
	life_bar.value -= damage
	hit_fx()
	if !life_bar.value:
		death()


func _physics_process(delta):
	set_velocity(velocity)
	move_and_slide()


func revive():
	if disabled:
		emit_signal("revive")
		life_bar.value = life_bar.max_value
		global_position = start_pos
		sprite.scale = Vector2.ONE
		self.disabled = false


func set_disabled(v):
	disabled = v
	visible = !v
	if disabled:
		_on_axis_changed(Vector2.ZERO)
	$Shape3D.set_deferred("disabled",v)
	$AreaHitBox/Shape3D.set_deferred("disabled",v)


func hit_fx():
	tween.interpolate_property(sprite,"scale",Vector2(2,2),Vector2.ONE,0.2,Tween.TRANS_CIRC,Tween.EASE_OUT)
	tween.interpolate_property(sprite,"modulate",Color(50,50,50),Color.WHITE,0.2,Tween.TRANS_CIRC,Tween.EASE_OUT)
	$SndHit.play()
	tween.start()


func death():
	tween.interpolate_property(sprite,"scale",Vector2(2,2),Vector2.ZERO,0.2,Tween.TRANS_CIRC,Tween.EASE_OUT)
	tween.start()
	await tween.tween_all_completed
	self.disabled = true


func _on_axis_changed(axis):
	velocity = axis*speed


func _on_AreaHitBox_body_entered(body):
	body.hit()
	body.push(global_position,50)
