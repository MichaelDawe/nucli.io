extends Control


var homepage = preload("res://homepage.tscn")


func _on_rich_text_label_2_pressed() -> void:
	var h = homepage.instantiate()
	get_parent().get_node("Content").free()
	get_parent().add_child(h)
	get_parent().move_child(h, 0)