extends Control

var _theme = 0
var themes = [preload("res://dark_theme.tres"), preload("res://light_theme.tres"), preload("res://user_theme.tres")]


var page = 0 # 404 = 404, 0 = Main, 1 = search, 2 = creator dashboard, 3 = settings, 4 = messages, 5 = friends, 6 = game, 7 = user, 8 = loading


var loading = preload("res://loading.tscn")
var other_user_page = preload("res://other_user_profile.tscn")
var game_page = preload("res://games_page.tscn")
var messages_page = preload("res://messages.tscn")
var friends_page = preload("res://view_friends.tscn")
var settings_page = preload("res://settings.tscn")
var c_dashboard = preload("res://creator_dashboard_upload.tscn") #TODO change to different page
var searchpage = preload("res://search.tscn")
var error404 = preload("res://404.tscn")


var lclicks_recorded = 0
var rclicks_recorded = 0
var mclicks_recorded = 0
var moves_recorded = 0


var hmcMain # hmc = heat map clicks (red = left, green = right, blue = middle)
var hmmMain # hmm = heat map movement
# screen size is 1728 width by 972 height.  Scroll height 1663 (TODO update this whenever I change the scroll container's contents.)
const hmTexSize = Vector2i((1728) / 3, (972 + 1663) / 3) # width, height


var heatmap_displayed = 0


var quit_confirm = preload("res://quit_confirm.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.volume_db = 10 * (log(32 / 100.0) / log(10))
	# stop it automatically quitting
	get_tree().set_auto_accept_quit(false)
	# setup blank textures for heatmapping 
	hmcMain = Image.create(hmTexSize.x, hmTexSize.y, false, Image.FORMAT_RGB8)
	hmcMain.fill(Color.BLACK)
	hmmMain = Image.create(hmTexSize.x, hmTexSize.y, false, Image.FORMAT_RGB8)
	hmmMain.fill(Color.BLACK)
	# TODO add all the pages here...
	# language menu
	$Header/VBoxContainer/HBoxContainer/Language.get_popup().connect("id_pressed", language_menu)
	# Catagories menu
	$Header/VBoxContainer/HBoxContainer/Catagories.get_popup().connect("id_pressed", catagories_menu)
	# Profile menu
	$Header/VBoxContainer/HBoxContainer/Profile.get_popup().connect("id_pressed", profile_menu)
	# Notifications menu
	$Header/VBoxContainer/HBoxContainer/Notifications.get_popup().connect("id_pressed", notifications_menu)
	# reset the scroll container
	$Content/ScrollContainer.scroll_vertical = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if page == 0:
		if $Content/ScrollContainer.scroll_vertical > 0:
			$Gradient.fadeOut(0.5)


func _on_theme_pressed() -> void:
	match _theme:
		0:
			theme = themes[1]
			$Gradient/TextureRect.modulate = Color.WHITE
			$Header.get_node("Background").get_theme_stylebox('panel').bg_color = Color("d3d9e8")
			_theme = 2 # TODO add 3rd theme again if time to fix background image and text boxes etc.
		1:
			theme = themes[2]
			$Gradient/TextureRect.modulate = Color(1, 0.5, 0.69)
			$Content/TextureBackground.visible = true
			$Header.get_node("Background").get_theme_stylebox('panel').bg_color = Color("ff7fb0")
			_theme = 2 
		2:
			theme = themes[0]
			$Gradient/TextureRect.modulate = Color.BLACK
			#$Content/TextureBackground.visible = false
			$Header.get_node("Background").get_theme_stylebox('panel').bg_color = Color("131415")
			_theme = 0


func _on_scroll_down_button_pressed() -> void:
	$Content/ScrollContainer.set_deferred("scroll_vertical", 890)
	$Gradient.fadeOut(0.5)


func _on_accept_concent_button_pressed() -> void:
	$Consent.visible = false


func _input(event: InputEvent) -> void:
	# Heatmaps
	# Mouse Movement
	match page:
		0:
			if event is InputEventMouseMotion:
				var pos
				if event.position.y < 76: # size of the header, so mouse is in the header
					pos = Vector2i(event.position.x / 3, event.position.y / 3)
				else: # mouse is in the page, so add page scroll
					pos = Vector2i(event.position.x / 3, (event.position.y + $Content/ScrollContainer.scroll_vertical) / 3)
				match page:
					0:
						moves_recorded += 1
						hmmMain.set_pixel(pos.x, pos.y, Color.GRAY)
					1:
						pass # game page TODO
					2:
						pass # etc...
				$MoveHeatmapDisplay.texture = ImageTexture.create_from_image(hmmMain)
			# Mouse Clicks
			elif event is InputEventMouseButton:
				var pos
				if event.position.y < 76: # size of the header, so mouse is in the header
					pos = Vector2i(event.position.x / 3, event.position.y / 3)
				else: # mouse is in the page, so add page scroll
					pos = Vector2i(event.position.x / 3, (event.position.y + $Content/ScrollContainer.scroll_vertical) / 3)
				var pixCol = Color.BLACK
				if event.button_index == MOUSE_BUTTON_LEFT:
					lclicks_recorded += 1
					pixCol = Color.RED
				elif event.button_index == MOUSE_BUTTON_RIGHT:
					rclicks_recorded += 1
					pixCol = Color.GREEN
				elif event.button_index == MOUSE_BUTTON_MIDDLE:
					mclicks_recorded += 1
					pixCol = Color.BLUE
				match page:
					0:
						hmcMain.set_pixel(pos.x, pos.y, pixCol)
						$ClickHeatmapDisplay.texture = ImageTexture.create_from_image(hmcMain)
					1:
						pass # game page TODO
					2:
						pass # etc...
			elif event is InputEventKey and Input.is_key_pressed(KEY_F3):
				match heatmap_displayed:
					0:
						heatmap_displayed = 1
						$ClickHeatmapDisplay.visible = true
					1:
						heatmap_displayed = 2
						$ClickHeatmapDisplay.visible = false
						$MoveHeatmapDisplay.visible = true
					2:
						heatmap_displayed = 0
						$MoveHeatmapDisplay.visible = false


# override quit
func _notification(what): if what == NOTIFICATION_WM_CLOSE_REQUEST: add_child(quit_confirm.instantiate())


func save_analitics():
	print(OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP))
	
	hmcMain.save_png(OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) + "/hmcMain.png")
	hmmMain.save_png(OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) + "/hmmMain.png")
	# TODO add all the pages here
	
	get_tree().quit()


func language_menu(id):
	match id:
		0: # english
			TranslationServer.set_locale("en")
		1: # welsh
			TranslationServer.set_locale("cy")
		2: # chinese
			TranslationServer.set_locale("zh")
		#etc.


func catagories_menu(id):
	page = 1
	var s = searchpage.instantiate()
	s.catagory = id
	get_node("Content").free()
	add_child(s)
	move_child(s, 0)
	get_node("Gradient").visible = false


func profile_menu(id):
	match id:
		1: #profile
			spawn_404()
		2: #dashboard
			page = 2
			var s = c_dashboard.instantiate()
			get_node("Content").free()
			add_child(s)
			move_child(s, 0)
			get_node("Gradient").visible = false
		3: #settings
			page = 3
			var s = settings_page.instantiate()
			get_node("Content").free()
			add_child(s)
			move_child(s, 0)
			get_node("Gradient").visible = false
		4: #help center
			spawn_404()
		5: #sign out
			spawn_404()


func notifications_menu(id):
	match id:
		1: #view messages
			page = 4
			var s = messages_page.instantiate()
			get_node("Content").free()
			add_child(s)
			move_child(s, 0)
			get_node("Gradient").visible = false
		2: #show friends list
			page = 5
			var s = friends_page.instantiate()
			get_node("Content").free()
			add_child(s)
			move_child(s, 0)
			get_node("Gradient").visible = false


func spawn_404():
	page = 404
	var s = error404.instantiate()
	get_node("Content").name = "tempyyyyaew908i3567q4pngfkl"
	add_child(s)
	move_child(s, 0)
	get_node("Gradient").visible = false
	get_node("tempyyyyaew908i3567q4pngfkl").queue_free()


func spawn_settings():
	page = 3
	var s = settings_page.instantiate()
	get_node("Content").name = "tempyyyyaew908i354567967q4pngfkl"
	add_child(s)
	move_child(s, 0)
	get_node("Gradient").visible = false
	get_node("tempyyyyaew908i354567967q4pngfkl").queue_free()


func spawn_game(id):
	page = 6
	var s = game_page.instantiate()
	s.id = id
	get_node("Content").name = "tempyyyyaew908i354567967q4pngfsdgjkl"
	add_child(s)
	move_child(s, 0)
	get_node("Gradient").visible = false
	get_node("tempyyyyaew908i354567967q4pngfsdgjkl").queue_free()
	

func spawn_user(id):
	page = 7
	var s = other_user_page.instantiate()
	s.id = id
	get_node("Content").name = "tempyyyysjthaew908i354567967q4pngfkl"
	add_child(s)
	move_child(s, 0)
	get_node("Gradient").visible = false
	get_node("tempyyyysjthaew908i354567967q4pngfkl").queue_free()


func spawn_loading():
	page = 8
	var s = loading.instantiate()
	get_node("Content").name = "tempyyyysjthaew908i354567967q4pw5jwngfkl"
	add_child(s)
	move_child(s, 0)
	get_node("Gradient").visible = false
	get_node("tempyyyysjthaew908i354567967q4pw5jwngfkl").queue_free()
