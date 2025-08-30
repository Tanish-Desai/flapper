extends Area2D

signal hit


# _on_body_entered is a general collision detect signal. _on_body_shape_entered is a more specific signal to detect specific shapes.
func _on_body_entered(body: Node2D) -> void:
	hit.emit()
