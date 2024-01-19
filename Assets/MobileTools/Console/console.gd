extends Control

var is_open = false
var original_position: Vector2
var target_position: Vector2
var current_lerp_factor: float = 0.0
var lerp_speed: float = 5  # Adjust this value to control the speed of the lerp

# Called when the node enters the scene tree for the first time.
func _ready():
	MultiTouchManager.updated.connect(_on_multi_touch_updated)
	original_position = position
	target_position = original_position + Vector2($Panel.size.x, 0)

func _on_multi_touch_updated(state):
	#is_open = !is_open
	pass

func _process(delta):
	if is_open and current_lerp_factor < 1.0:
		current_lerp_factor += lerp_speed * delta
	elif not is_open and current_lerp_factor > 0.0:
		current_lerp_factor -= lerp_speed * delta

	current_lerp_factor = clamp(current_lerp_factor, 0.0, 1.0)
	position = original_position.lerp(target_position, current_lerp_factor)
