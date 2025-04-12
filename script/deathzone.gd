extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	#print("Out of bounds - Restarting game")
	timer.start()


func _on_timer_timeout() -> void:
	SaveManager.add_score(ScoreManager.total_score)
	ScoreManager.total_score = 0
	get_tree().call_deferred("reload_current_scene")
