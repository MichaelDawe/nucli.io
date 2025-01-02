extends Control


var timer = 0
var TIMEIT = 4
var frametimer = 0
var FPS = 15


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > TIMEIT:
		get_parent().spawn_404()
	# animation
	frametimer += delta * FPS
	if frametimer >= 5:
		frametimer = 0
	$Loading.frame = int(frametimer)
	
