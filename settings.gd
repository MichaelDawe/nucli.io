extends Control


func _ready() -> void:
	var v = get_parent().get_node("AudioStreamPlayer2D").volume_db
	var k = pow(10, (v / 10.0))
	$HSlider.value = 100 * k


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	get_parent().get_node("AudioStreamPlayer2D").volume_db = 10 * (log($HSlider.value / 100.0) / log(10))
