extends Node


var fadeout = false
var fadeoutTime = 1.0 # seconds
var fade = 1.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fadeout:
		fade -= delta*(1.0 / fadeoutTime)
		$".".modulate = Color(1, 1, 1, fade)
		if fade <= 0:
			$".".visible = false


func fadeOut(time):
	fadeout = true
	fadeoutTime = time
