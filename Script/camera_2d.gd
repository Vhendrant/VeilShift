extends Camera2D
@onready var player = $"../CharacterBody2D"
var speed = 5.0

func _process(delta):
	if player:
		global_position = global_position.lerp(
			player.global_position,
			speed * delta)
