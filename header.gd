extends Control


var search = false


var homepage = preload("res://homepage.tscn")
var searchpage = preload("res://search.tscn")


func _on_theme_pressed() -> void:
	get_parent()._on_theme_pressed()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		if $VBoxContainer/HBoxContainer/SearchBarText.has_focus():
			load_search()


func _on_search_button_pressed() -> void:
	load_search()


func load_search():
	get_parent().page = 1
	var query = $VBoxContainer/HBoxContainer/SearchBarText.text
	var s = searchpage.instantiate()
	s.query = query
	get_parent().get_node("Content").free()
	get_parent().add_child(s)
	get_parent().move_child(s, 0)
	get_parent().get_node("Gradient").visible = false


func _on_logo_pressed() -> void:
	get_parent().page = 0
	var h = homepage.instantiate()
	get_parent().get_node("Content").free()
	get_parent().add_child(h)
	get_parent().move_child(h, 0)
