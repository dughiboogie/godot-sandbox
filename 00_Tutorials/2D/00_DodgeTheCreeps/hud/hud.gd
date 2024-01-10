extends CanvasLayer

# Notifies Main scene that the start button has been pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreLabel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over_message(final_score, high_score):
	show_message("Game over!")
	
	# Wait until the MessageTimer node has reached zero
	await $MessageTimer.timeout
	
	$ScoreLabel.hide()
	show_message("Final score:\n" + str(final_score))
	await  $MessageTimer.timeout
	
	# $Message.text = "Final score:\n" + str(final_score)
	# $Message.show()
	
	# Make an anonymous timer (one-shot) and wait for it to finish
	# Similar to thread.sleep(t)
	# await get_tree().create_timer(1.0).timeout
	
	$ScoreLabel.text = "Highscore: " + str(high_score)
	$ScoreLabel.show()
	$Message.text = "Dodge the creeps!"
	$Message.show()
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_message_timer_timeout():
	$Message.hide()

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
