extends TextureRect

var console = Control
var _opened = false

# Called when the node enters the scene tree for the first time.
func _ready():
	console = get_node("../")

func _on_gui_input(event):
	
	pass # Replace with function body.
