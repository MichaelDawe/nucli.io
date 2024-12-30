extends VBoxContainer

var hidee = false

func _ready() -> void:
	if hidee:
		modulate = Color(0, 0, 0, 0)
