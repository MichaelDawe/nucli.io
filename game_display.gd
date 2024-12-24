extends VBoxContainer


var thumbnail = ""
var username = ""
var userpic = ""
var title = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Thumbnail.icon = load("res://game_images/" + thumbnail)
	$Username.icon = load("res://game_images/" + userpic)
	$Username.text = username
	$Description.text = title
