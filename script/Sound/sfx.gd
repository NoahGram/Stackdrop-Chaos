extends Node

@onready var block_spawned_sound: AudioStreamPlayer = $BlockSpawnedSound
@onready var block_landed_sound: AudioStreamPlayer = $BlockLandedSound
@onready var pause_open_sound: AudioStreamPlayer = $PauseOpenSound
@onready var pause_close_sound: AudioStreamPlayer = $PauseCloseSound


func play_pausescreen_open():
	pause_open_sound.play()
	
func play_pausescreen_close():
	pause_close_sound.play()

func block_spawned():
	block_spawned_sound.play()

func block_landed():
	block_landed_sound.play()
