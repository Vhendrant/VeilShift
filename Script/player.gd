extends CharacterBody2D

var direction : Vector2 = Vector2.ZERO
var move_speed : float = 100.0
var dash_speed : float = 500.0
var dash_duration : float = 0.075
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
var last_direction = Vector2.DOWN
var grace_period = 0.05
var dash : bool = false

func _ready():
	animation_tree.active = true
	pass
	
func _physics_process(delta):
	if dash:
		_process_dash(delta)
	else:
		_process_normal(delta)
	move_and_slide()

func _process_normal(delta):
	direction = Vector2(
		Input.get_axis("Left", "Right"), 
		Input.get_axis("Up", "Down")
	).normalized()
	
	if Input.is_action_just_pressed("Dash") and direction != Vector2.ZERO:
		_process_dash(delta)
		return
	velocity = direction * move_speed
	
	if grace_period > 0.0:
		grace_period -= delta
	if direction.x != 0 and direction.y != 0:
		last_direction = direction
		grace_period = 0.05
	elif direction != Vector2.ZERO:
		if grace_period <= 0:
			last_direction = direction

	animation_tree.set("parameters/Idle/blend_position", last_direction)
	animation_tree.set("parameters/Run/blend_position", last_direction)

func _process_dash(delta):
	dash = true
	dash_duration -= delta
	animation_tree.process_mode = Node.PROCESS_MODE_DISABLED
	velocity = dash_speed * direction
	if dash_duration <= 0:
		dash_duration = 0.075
		animation_tree.process_mode = Node.PROCESS_MODE_INHERIT
		dash = false
