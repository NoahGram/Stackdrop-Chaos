extends Control

@onready var main_scene = preload("res://scene/game_manager.tscn")


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)

func _on_exit_pressed() -> void:
	get_tree().quit()
