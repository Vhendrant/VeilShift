extends CharacterBody2D

var direction : Vector2 = Vector2.ZERO
var move_speed : float = 100.0

func _ready():
	pass

func _process(delta):
	direction = Vector2(
		Input.get_axis("Left", "Right"), 
		Input.get_axis("Up", "Down")
	).normalized()
	velocity = direction * move_speed
	return velocity

func _physics_process(delta):
	move_and_slide()
