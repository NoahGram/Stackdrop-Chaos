extends Control

@onready var display_settings: Control = $DisplaySettings
@onready var sound_settings: Control = $SoundSettings
@onready var input_settings: Control = $InputSettings


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/titlescreen.tscn")


func _on_button_display_settings_pressed() -> void:
	display_settings.visible = true
	sound_settings.visible = false
	input_settings.visible = false

func _on_button_audio_settings_pressed() -> void:
	display_settings.visible = false
	sound_settings.visible = true
	input_settings.visible = false


func _on_button_key_settings_pressed() -> void:
	display_settings.visible = false
	sound_settings.visible = false
	input_settings.visible = true
