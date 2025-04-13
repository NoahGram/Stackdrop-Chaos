extends Node2D

@onready var pause_screen: CanvasLayer = $PauseScreen
@onready var death_screen: CanvasLayer = $DeathScreen
@onready var title_screen = preload("res://scene/titlescreen.tscn")


func _ready() -> void:
	BackgroundMusic.get_node_or_null("AudioStreamPlayer").stream.loop = true

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("pause") and death_screen.visible == false:
		toggle_pause()
		
		if pause_screen.visible:
			Sfx.play_pausescreen_open()
		else:
			Sfx.play_pausescreen_close()
		
func toggle_pause():
	get_tree().paused = not get_tree().paused
	pause_screen.visible = !pause_screen.visible


func _on_resume_pressed() -> void:
	toggle_pause()


func _on_quit_pressed() -> void:
	pause_screen.visible = !pause_screen.visible
	get_tree().quit()


func _on_back_to_titlescreen_pressed() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://scene/titlescreen.tscn")


func _on_play_again_pressed() -> void:
	toggle_pause()
	get_tree().reload_current_scene()
