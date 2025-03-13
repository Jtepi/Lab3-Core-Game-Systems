extends Area2D

# Signal emitted when the player hits the ground
signal hit

# Handles collision with the player
func _on_body_entered(body):
	hit.emit()  # Notifies main script that player hit the ground
