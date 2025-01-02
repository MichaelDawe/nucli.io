extends VBoxContainer


var id = -1


var thumbnail = ""
var username = ""
var userpic = ""
var title = ""

var main

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Thumbnail.icon = load("res://game_images/" + thumbnail)
	$Username.icon = load("res://game_images/" + userpic)
	$Username.text = username
	$Description.text = title
	
	main = get_parent().get_parent().get_parent().get_parent().get_parent()


func _on_thumbnail_pressed() -> void:
	main.spawn_game(id)


func _on_username_pressed() -> void:
	main.spawn_user(id)
