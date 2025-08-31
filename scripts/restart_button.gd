extends Button

signal restart



func _on_pressed() -> void:
	restart.emit()
