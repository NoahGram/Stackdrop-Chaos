extends Area2D

@onready var timer: Timer = $Timer
@onready var death_screen := get_tree().get_root().get_node("GameManager/DeathScreen")
@onready var highscore: Label = get_tree().get_root().get_node("GameManager/DeathScreen/Control/Panel/Highscore")
@onready var camera: Camera2D = $"../Spawner/Camera"

func _on_body_entered(body: Node2D) -> void:
	camera.start_shake(10.0)
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().paused = not get_tree().paused
	if ScoreManager.total_score != 0:
		SaveManager.add_score(ScoreManager.total_score)
	death_screen.visible = !death_screen.visible
	highscore.text = str(ScoreManager.total_score)
	ScoreManager.total_score = 0
