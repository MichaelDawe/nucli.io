extends HBoxContainer

var scene_count = 0
@export var ad : PackedScene

func add_game(scene):
	scene_count += 1
	if scene_count > 5:
		return false
	else:
		add_child(scene)
		add_child($VSeparator.duplicate())
	return true

func add_ad():
	scene_count += 1
	add_child(ad.instantiate())
	add_child($VSeparator.duplicate())

func space():
	while scene_count < 5:
		scene_count += 1
		var a = ad.instantiate()
		a.hidee = true
		add_child(a)
		add_child($VSeparator.duplicate())
