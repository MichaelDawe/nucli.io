extends Window


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_save_analitics_pressed() -> void:
	get_parent().save_analitics()
