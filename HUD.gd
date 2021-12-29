extends CanvasLayer

signal start_game


func show_message(text: String):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")

	yield($MessageTimer, "timeout")

	$Message.text = "Dodge the Creeps!"
	$Message.show()

	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
