extends CanvasLayer

# Signal emitted when restart button is pressed
signal restart

# Handles button press to restart game
func _on_button_pressed():
	restart.emit()  # Notifies main script to restart
