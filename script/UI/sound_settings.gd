extends Control

@onready var h_slider_background: HSlider = $PanelContainer/MarginContainer/VBoxContainer/BackgroundMusic/HSliderBackground
@onready var h_slider_sfx: HSlider = $PanelContainer/MarginContainer/VBoxContainer/SfxMusic/HSliderSfx


var music_volume_db: float = BackgroundMusic.get_node_or_null("AudioStreamPlayer").volume_db
var sfx_volume_db: float = Sfx.block_spawned_sound.volume_db


func _ready() -> void:
	var music_player = BackgroundMusic.get_node_or_null("AudioStreamPlayer")
	if music_player:
		music_player.volume_db = music_volume_db
		h_slider_background.value = music_volume_db

	var value = sfx_volume_db
	h_slider_sfx.value = value
	Sfx.block_spawned_sound.volume_db = value
	Sfx.block_landed_sound.volume_db = value
	Sfx.pause_open_sound.volume_db = value
	Sfx.pause_close_sound.volume_db = value

func _on_background_music_value_changed(value: float) -> void:
	var music_player = BackgroundMusic.get_node_or_null("AudioStreamPlayer")
	if music_player:
		music_player.volume_db = value
	music_volume_db = value


func _on_sfx_value_changed(value: float) -> void:
	Sfx.block_spawned_sound.volume_db = value
	Sfx.block_landed_sound.volume_db = value
	Sfx.pause_open_sound.volume_db = value
	Sfx.pause_close_sound.volume_db = value
	sfx_volume_db = value
	
