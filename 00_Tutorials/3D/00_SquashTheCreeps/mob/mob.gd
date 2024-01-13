extends CharacterBody3D

@export var min_speed = 10
@export var max_speed = 18

func _physics_process(delta):
	move_and_slide()

# This function is called from the Main scene to initialize mobs
func initialize(start_position, player_position):
	# look_at_from_position updates the rotation (look_at) and position at the same time
	look_at_from_position(start_position, player_position, Vector3.UP)
	# Rotate the mob randomly between -45° and 45° to not look at the player super directly
	rotate_y(randf_range(-PI/4, PI/4))
	
	# Calculate random speed (integer)
	var random_speed = randi_range(min_speed, max_speed)
	# Calculate forward velocity
	velocity = Vector3.FORWARD * random_speed
	# Rotate velocity vector based on the mob's Y rotation, to move in the direction the mob is looking
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
