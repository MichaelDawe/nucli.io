extends Control

var _theme = 0
var themes = [preload("res://dark_theme.tres"), preload("res://light_theme.tres"), preload("res://user_theme.tres")]
var styleboxes = [preload("res://dark_theme_search_stylebox.tres"), preload("res://light_theme_search_stylebox.tres"), preload("res://user_theme_search_stylebox.tres")]


var page = 0 # 0 = Main, 1 = Game, etc...


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
	# stop it automatically quitting
	get_tree().set_auto_accept_quit(false)
	# setup blank textures for heatmapping 
	hmcMain = Image.create(hmTexSize.x, hmTexSize.y, false, Image.FORMAT_RGB8)
	hmcMain.fill(Color.BLACK)
	hmmMain = Image.create(hmTexSize.x, hmTexSize.y, false, Image.FORMAT_RGB8)
	hmmMain.fill(Color.BLACK)
	# TODO add all the pages here...
	# language menu
	var popup = $Header/VBoxContainer/HBoxContainer/Language.get_popup()
	popup.connect("id_pressed", language_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $Content/ScrollContainer.scroll_vertical > 0:
		$Gradient.fadeOut(0.5)


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
	$Gradient.fadeOut(0.5)


func _on_accept_concent_button_pressed() -> void:
	$Consent.visible = false


func _input(event: InputEvent) -> void:
	# Heatmaps
	# Mouse Movement
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


func change_language(lang):
	pass


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
