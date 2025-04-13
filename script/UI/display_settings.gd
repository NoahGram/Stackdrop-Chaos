extends Control

@onready var resolution_options: OptionButton = $PanelContainer/MarginContainer/VBoxContainer/ResolutionType/ResolutionOptionButton
@onready var display_mode_options: OptionButton = $PanelContainer/MarginContainer/VBoxContainer/DisplayType/DisplayOptionButton
@onready var monitor_selector: OptionButton = $PanelContainer/MarginContainer/VBoxContainer/MonitorType/MonitorOptionButton



var resolutions = {
	0: Vector2i(640, 480),
	1: Vector2i(1152, 648),
	2: Vector2i(1600, 900),
	3: Vector2i(1920, 1080),
	4: Vector2i(3840, 2160),
}


func _ready() -> void:
	display_mode_options.select(1)
	resolution_options.select(1)
	populate_monitor_options()
	resolution_options.disabled = true


func _process(delta: float) -> void:
	pass


func _on_resolution_item_selected(index: int) -> void:
	if resolutions.has(index):
		var new_resolution = resolutions[index]
		DisplayServer.window_set_size(new_resolution)



func _on_display_item_selected(index: int) -> void:
	match index:
		0: 
			resolution_options.select(1)
			resolution_options.disabled = false
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			
		1:
			_on_resolution_item_selected(1)
			resolution_options.disabled = true
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		2: 
			_on_resolution_item_selected(1)
			resolution_options.disabled = true
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			
		3: 
			_on_resolution_item_selected(1)
			resolution_options.disabled = true
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		_: print("Error: Display Mode Unavailible")


func populate_monitor_options():
	var monitor_count = DisplayServer.get_screen_count()

	for i in range(monitor_count):
		monitor_selector.add_item("Monitor " + str(i + 1), i)

	var current_monitor = DisplayServer.window_get_current_screen()
	monitor_selector.select(current_monitor)

func _on_monitor_item_selected(index: int) -> void:
	DisplayServer.window_set_current_screen(index)


func _on_v_sync_toggled(checked: bool) -> void:
	if checked:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
