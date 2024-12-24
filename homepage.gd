extends Control

var games = {}
@export var game_display : PackedScene
@export var game_section : PackedScene
var ad_display = false
var ad_index = 0
var cat_count = 0

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
	# loop through all games and add them to page
	# every second row insert an ad at a random position
	var gcat = game_section.instantiate()
	for i in len(games[1]):
		if ad_display and i == ad_index:
			gcat.add_ad()
		var gd = game_display.instantiate()
		gd.title = games[1][i]
		gd.thumbnail = games[2][i]
		gd.username = games[3][i]
		gd.userpic = games[4][i]
		if not gcat.add_game(gd):
			add_cat(gcat)
			gcat = game_section.instantiate()
			gcat.add_game(gd)
			ad_display = !ad_display
			ad_index = randi_range(0, 4)
	add_cat(gcat)
			
func add_cat(scene):
	if cat_count == 0:
		$ScrollContainer/VBoxContainer/new_games.add_sibling(scene)
	elif cat_count == 1:
		$ScrollContainer/VBoxContainer/popular_games.add_sibling(scene)
	elif cat_count == 2:
		$ScrollContainer/VBoxContainer/HSeparator3.add_sibling(scene)
	else:
		$ScrollContainer/VBoxContainer/all_games.add_child(scene)
	cat_count += 1
