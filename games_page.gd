extends Control


var id = -1
var games = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# fill all games from games.csv
	var file = FileAccess.open("res://games.txt", FileAccess.READ)
	while !file.eof_reached():
		var data_set = Array(file.get_csv_line())
		games[games.size()] = data_set
	file.close()
	# remove unneeded data
	games.erase(0)
	games.erase(len(games))
	for row in games:
		games[row].remove_at(0)
		
	var title = games[1][id]
	var thumbnail = games[2][id]
	var username = games[3][id]
	var userpic = games[4][id]
	var description = games[9][id]
		
	# setup the page contents
	$MarginContainer/HBoxContainer/ScrollContainer/GameMain/MarginContainer/VBoxContainer/CoverArt.texture = load("res://game_images/" + thumbnail)
	$MarginContainer/HBoxContainer/ScrollContainer/GameMain/MarginContainer/VBoxContainer/GameTitle.text = title
	$MarginContainer/HBoxContainer/ScrollContainer/GameMain/MarginContainer/VBoxContainer/Username.icon = load("res://game_images/" + userpic)
	$MarginContainer/HBoxContainer/ScrollContainer/GameMain/MarginContainer/VBoxContainer/Username.text = username
	$MarginContainer/HBoxContainer/ScrollContainer/GameMain/MarginContainer/VBoxContainer/Description.text = description


func _on_play_pressed() -> void:
	get_parent().spawn_loading()


func _on_username_pressed() -> void:
	get_parent().spawn_user(id)
