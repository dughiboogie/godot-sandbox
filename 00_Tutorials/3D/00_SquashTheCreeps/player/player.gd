extends CharacterBody3D

# Player speed in m/s
@export var speed = 14
# Player downward acceleration in m/s^2
@export var gravity_acceleration = 75

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	# Local variable to track input direction
	var direction = Vector3.ZERO
	
	# Update direction based on player input
	# In 3D XZ is the ground plane, while Y is the elevation
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
	
	# Calculate movement velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Calculate vertical velocity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (gravity_acceleration * delta)
	
	# Actual player movement
	velocity = target_velocity
	move_and_slide()
