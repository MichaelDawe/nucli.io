extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_expand_sidebar_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Popout_Menu.visible = true
	else:
		$Popout_Menu.visible = false
