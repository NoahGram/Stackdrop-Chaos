extends Node2D

@onready var pause_screen: CanvasLayer = $PauseScreen
@onready var title_screen = preload("res://scene/titlescreen.tscn")
@onready var background_music_slider: HSlider = $PauseScreen/Control/Panel/BackgroundMusicSlider

func _ready() -> void:
	BackgroundMusic.get_node_or_null("AudioStreamPlayer").stream.loop = true

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


func _on_back_to_titlescreen_pressed() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://scene/titlescreen.tscn")


func _on_background_music_value_changed(value: float) -> void:
	BackgroundMusic.get_node_or_null("AudioStreamPlayer").volume_db = value
