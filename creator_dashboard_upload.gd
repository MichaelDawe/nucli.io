extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_expand_sidebar_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Popout_Menu.visible = true
	else:
		$Popout_Menu.visible = false


func _on_upload_new_pressed() -> void:
	# TEMP :(
	$_CreatorDashboardHome.visible = false
	$_YourGameAnalytics.visible = false
	$_YourGames.visible = false
	$_CreatorAnalitics1.visible = false
	$_CreatorAnalitics2.visible = false
	$_CreatorAnalitics3.visible = false
	# Actual
	$ScrollContainer/VBoxContainer/UploadNew.visible = true
	$ScrollContainer/VBoxContainer/CreatorDashboardHome.visible = false
	$ScrollContainer/VBoxContainer/YourGameAnalitics.visible = false
	$ScrollContainer/VBoxContainer/YourGames.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics1.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics2.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics3.visible = false


func _on_creator_analitics_pressed() -> void:
	# TEMP :(
	$_CreatorDashboardHome.visible = false
	$_YourGameAnalytics.visible = false
	$_YourGames.visible = false
	$_CreatorAnalitics1.visible = true
	$_CreatorAnalitics2.visible = false
	$_CreatorAnalitics3.visible = false
	# Actual
	$ScrollContainer/VBoxContainer/UploadNew.visible = false
	$ScrollContainer/VBoxContainer/CreatorDashboardHome.visible = false
	$ScrollContainer/VBoxContainer/YourGameAnalitics.visible = false
	$ScrollContainer/VBoxContainer/YourGames.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics1.visible = true
	$ScrollContainer/VBoxContainer/CreatorAnalitics2.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics3.visible = false


func _on_your_games_pressed() -> void:
	# TEMP :(
	$_CreatorDashboardHome.visible = false
	$_YourGameAnalytics.visible = false
	$_YourGames.visible = true
	$_CreatorAnalitics1.visible = false
	$_CreatorAnalitics2.visible = false
	$_CreatorAnalitics3.visible = false
	# Actual
	$ScrollContainer/VBoxContainer/UploadNew.visible = false
	$ScrollContainer/VBoxContainer/CreatorDashboardHome.visible = false
	$ScrollContainer/VBoxContainer/YourGameAnalitics.visible = false
	$ScrollContainer/VBoxContainer/YourGames.visible = true
	$ScrollContainer/VBoxContainer/CreatorAnalitics1.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics2.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics3.visible = false


func _on_game_analitics_pressed() -> void:
	# TEMP :(
	$_CreatorDashboardHome.visible = false
	$_YourGameAnalytics.visible = true
	$_YourGames.visible = false
	$_CreatorAnalitics1.visible = false
	$_CreatorAnalitics2.visible = false
	$_CreatorAnalitics3.visible = false
	# Actual
	$ScrollContainer/VBoxContainer/UploadNew.visible = false
	$ScrollContainer/VBoxContainer/CreatorDashboardHome.visible = false
	$ScrollContainer/VBoxContainer/YourGameAnalitics.visible = true
	$ScrollContainer/VBoxContainer/YourGames.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics1.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics2.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics3.visible = false


func _on_creator_cap_pressed() -> void:
	# TEMP :(
	$_CreatorAnalitics1.visible = true
	$_CreatorAnalitics2.visible = false
	$_CreatorAnalitics3.visible = false
	# Actual
	$ScrollContainer/VBoxContainer/CreatorAnalitics1.visible = true
	$ScrollContainer/VBoxContainer/CreatorAnalitics2.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics3.visible = false


func _on_games_cap_pressed() -> void:
	# TEMP :(
	$_CreatorAnalitics1.visible = false
	$_CreatorAnalitics2.visible = true
	$_CreatorAnalitics3.visible = false
	# Actual
	$ScrollContainer/VBoxContainer/CreatorAnalitics1.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics2.visible = true
	$ScrollContainer/VBoxContainer/CreatorAnalitics3.visible = false


func _on_audience_cap_pressed() -> void:
	# TEMP :(
	$_CreatorAnalitics1.visible = false
	$_CreatorAnalitics2.visible = false
	$_CreatorAnalitics3.visible = true
	# Actual
	$ScrollContainer/VBoxContainer/CreatorAnalitics1.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics2.visible = false
	$ScrollContainer/VBoxContainer/CreatorAnalitics3.visible = true


func _on_promote_your_game_pressed() -> void:
	get_parent().spawn_404()


func _on_share_profile_pressed() -> void:
	get_parent().spawn_404()


func _on_help_pressed() -> void:
	get_parent().spawn_404()


func _on_settings_pressed() -> void:
	get_parent().spawn_settings()


func _on_report_problem_pressed() -> void:
	get_parent().spawn_404()
