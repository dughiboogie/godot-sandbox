extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var target: Node3D = null


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle movement/deceleration.
	#if target != null:
		#var direction = (transform.basis * target.global_position).normalized()
		#if direction:
			#velocity.x = direction.x * SPEED
			#velocity.z = direction.z * SPEED
		#else:
			#velocity.x = 0.0
			#velocity.z = 0.0

	move_and_slide()


func _on_player_detection_area_body_entered(body):
	if body.name == "Player":
		print("New player target!")
		target = body


func _on_player_detection_area_body_exited(body):
	if body.name == "Player":
		print("Lost player target!")
		target = null
