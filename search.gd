extends Control

var catagory = 0
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
	
	# display catagories
	if catagory > 0:
		var cat_query = ""
		match catagory:
			1: #new
				cat_query = "NEW"
			2: #featured
				cat_query = "FEATURED"
			3: #popular
				cat_query = "POPULAR"
			4: #random
				spawn_random_game()
			5: #adventure
				cat_query = "ADVENTURE"
			6: #action
				cat_query = "ACTION"
			7: #stratagy
				cat_query = "STRATEGY"
			8: #puzzle
				cat_query = "PUZZLE"
			9: #horror
				cat_query = "HORROR"
			10: #survival
				cat_query = "SURVIVAL"
			11: #simulation
				cat_query = "SIMULATION"
			12: #fps
				cat_query = "FPS"
			13: #driving
				cat_query = "DRIVING"
			14: #casual
				cat_query = "CASUAL"
			15: #solo
				cat_query = "SOLO"
			16: #co-op
				cat_query = "CO_OP"
			17: #pvp
				cat_query = "PVP"
		query = cat_query.to_lower()
		# if query in tags: add game index to matches
		for i in len(games[1]):
			if query in games[8][i].to_lower():
				matches.append(i)
	else:
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
		gd.id = matches[i]
		if not gcat.add_game(gd):
			add_cat(gcat)
			gcat = game_section.instantiate()
			gcat.add_game(gd)
			ad_index = randi_range(1, 3)
	gcat.space()
	add_cat(gcat)
	# say no results if no results
	if len(matches) == 0:
		$ScrollContainer/VBoxContainer/No_Results.visible = true
			
func add_cat(scene):
	$ScrollContainer/VBoxContainer.add_child(scene)
	$ScrollContainer/VBoxContainer.move_child(scene, $ScrollContainer/VBoxContainer/HSeparator5.get_index())

func spawn_random_game():
	get_parent().spawn_game(randi_range(0, len(games[1]) - 1))
