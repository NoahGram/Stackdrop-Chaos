extends Node2D

@onready var pause_screen: CanvasLayer = $PauseScreen

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("pause"):
		toggle_pause()
		
func toggle_pause():
	get_tree().paused = not get_tree().paused
	pause_screen.visible = !pause_screen.visible


func _on_resume_pressed() -> void:
	toggle_pause()


func _on_quit_pressed() -> void:
	pause_screen.visible = !pause_screen.visible
	get_tree().quit()
