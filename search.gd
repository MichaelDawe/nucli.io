extends Control


var query = ""
var query_words = ""
var matches = []
var games = {}
@export var game_display : PackedScene
@export var game_section : PackedScene
var ad_display = true
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
	# make query lowercase and split into words
	query = query.to_lower()
	query_words = query.split(" ")
	# if whole query in title: add game index to matches
	for i in len(games[1]):
		if query in games[1][i].to_lower():
			matches.append(i)
	# if whole query in username, and not already in matches: add game index to matches
	for i in len(games[1]):
		if query in games[3][i].to_lower() and i not in matches:
			matches.append(i)
	# if words in query are in title, and not already in matches: add game index to matches
	for i in len(games[1]):
		for word in query_words:
			if word in games[1][i].to_lower() and i not in matches:
				matches.append(i)
	# if words in query are in username, and not already in matches: add game index to matches
	for i in len(games[1]):
		for word in query_words:
			if word in games[3][i].to_lower() and i not in matches:
				matches.append(i)
	# loop through matches and add games to page same as homepage does
	var gcat = game_section.instantiate()
	ad_index = randi_range(1, 3)
	for i in len(matches):
		if fmod(i, 4) == ad_index:
			gcat.add_ad()
		var gd = game_display.instantiate()
		gd.title = games[1][matches[i]]
		gd.thumbnail = games[2][matches[i]]
		gd.username = games[3][matches[i]]
		gd.userpic = games[4][matches[i]]
		if not gcat.add_game(gd):
			add_cat(gcat)
			gcat = game_section.instantiate()
			gcat.add_game(gd)
			ad_index = randi_range(1, 3)
	gcat.space()
	add_cat(gcat)
			
func add_cat(scene):
	$ScrollContainer/VBoxContainer.add_child(scene)
	$ScrollContainer/VBoxContainer.move_child(scene, $ScrollContainer/VBoxContainer/HSeparator5.get_index())
