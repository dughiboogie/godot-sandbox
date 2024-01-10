extends Node

@export var mob_scene: PackedScene

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over_message(score)

func new_game():
	get_tree().call_group("mobs", "queue_free")
	
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD/ScoreLabel.show()
	$HUD.update_score(score)
	$HUD.show_message("Get ready!")

func _on_score_timer_timeout():
	score += 1
	print(score)
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	# Create new instance of Mob scene
	var mob = mob_scene.instantiate()
	
	# Choose random location on Path2D
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Set mob position to calculated position
	mob.position = mob_spawn_location.position
	
	# Set mob direction perpendicular to path direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Add randomness to direction
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Set random mob speed
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated((direction))
	
	# Spawn mob by adding it to Main scene
	add_child(mob)











