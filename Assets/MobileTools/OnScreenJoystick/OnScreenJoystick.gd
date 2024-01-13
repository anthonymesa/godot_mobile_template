extends Control

signal updated

@export var joy_width = 0
@export var base_width = 0
@export var return_speed = 0

var _base_center = Vector2.ZERO
var is_being_dragged = false

func _ready():
	set_process_unhandled_input(true)
	size = Vector2.ONE * base_width
	$Joystick.size = Vector2.ONE * joy_width
	$Base.size = Vector2.ONE * base_width
	$Base.position = Vector2.ZERO
	_base_center = $Base.position + ($Base.size / 2)
	$Joystick.position = _base_center - ($Joystick.size / 2)

func _process(delta):
	if !is_being_dragged:
		$Joystick.position = $Joystick.position.lerp(_base_center - ($Joystick.size / 2), delta * return_speed)

func move_joystick(mouse_pos):
	var global_mouse_pos = get_global_mouse_position()
	var joystick_half_size = $Joystick.size / 2
	var new_pos = global_mouse_pos - joystick_half_size - position
	$Joystick.position = new_pos
	var real_value = (new_pos - _base_center + ($Joystick.size / 2))
	var scaled_value = real_value / ((base_width/2) - (joy_width / 2))
	if scaled_value.length() < 1:
		$Joystick.position = new_pos
	else: 
		var computed_position = ($Joystick.position - ($Base.size/2) + ($Joystick.size / 2))
		$Joystick.position = (computed_position.normalized() * ((base_width / 2) - (joy_width / 2))) - ($Joystick.size / 2) + ($Base.size / 2)
	var output = (($Joystick.position + ($Joystick.size / 2) - _base_center)) / (($Base.size / 2) - ($Joystick.size / 2))
	#print_debug(snapped(output.length(), .01))
	
func _on_joystick_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_being_dragged = true
			else:
				is_being_dragged = false
	elif event is InputEventMouseMotion:
		if is_being_dragged:
			move_joystick(event.position)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		is_being_dragged = false
