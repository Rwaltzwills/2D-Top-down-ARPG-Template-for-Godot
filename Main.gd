extends Node

@export var enemy_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$ScoreTimer.stop()
	$EnemySpawn.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_player_hit():
	game_over() 
	$HUD.show_game_over()
# Replace with function body.


func _on_start_timer_timeout():
	$ScoreTimer.start()
	$EnemySpawn.start()
	# Replace with function body.


func _on_score_timer_timeout():
	score += 1 
	$HUD.update_score(score)
# Replace with function body.


func _on_enemy_spawn_timeout():
	var enemy = enemy_scene.instantiate() # Replace with function body.
	var enemy_spawn_location = get_node("EnemySpawns/EnemySpawnLocation")
	enemy_spawn_location.progress_ratio = randf()
	enemy.position = enemy_spawn_location.position
	var velocity = Vector2(randf_range(150.0,250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(180)
	add_child(enemy)


func _on_hud_start_game():
	new_game() # Replace with function body.
