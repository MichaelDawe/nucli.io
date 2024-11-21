extends Control

var _theme = 0
var themes = [preload("res://dark_theme.tres"), preload("res://light_theme.tres"), preload("res://user_theme.tres")]
var styleboxes = [preload("res://dark_theme_search_stylebox.tres"), preload("res://light_theme_search_stylebox.tres"), preload("res://user_theme_search_stylebox.tres")]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $Content/ScrollContainer.scroll_vertical > 0:
		$Gradient.visible = false


func _on_theme_pressed() -> void:
	match _theme:
		0:
			theme = themes[1]
			$Gradient/TextureRect.modulate = Color.WHITE
			$Header/VBoxContainer/HBoxContainer/SearchBar.add_theme_stylebox_override("normal", styleboxes[1])
			_theme = 1
		1:
			theme = themes[2]
			$Gradient/TextureRect.modulate = Color(1, 0.5, 0.69)
			$Header/VBoxContainer/HBoxContainer/SearchBar.add_theme_stylebox_override("normal", styleboxes[2])
			$Content/TextureBackground.visible = true
			_theme = 2
		2:
			theme = themes[0]
			$Gradient/TextureRect.modulate = Color.BLACK
			$Header/VBoxContainer/HBoxContainer/SearchBar.add_theme_stylebox_override("normal", styleboxes[0])
			$Content/TextureBackground.visible = false
			_theme = 0


func _on_scroll_down_button_pressed() -> void:
	$Content/ScrollContainer.set_deferred("scroll_vertical", 890)
	$Gradient.visible = false
