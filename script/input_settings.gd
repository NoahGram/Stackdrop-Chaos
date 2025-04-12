extends Control

@onready var input_button_scene = preload("res://scene/input_button.tscn")
@onready var action_list: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remapping = false
var action_to_remap = null
var remapping_button = null

var font = preload("res://assets/fonts/PixelOperator8.ttf")
var font_color = Color("White")
var font_size = 16

var input_actions = {
	"left": "Left",
	"right": "Right",
	"rotate": "Rotate",
	"drop_block": "Drop Block",
}

func _ready() -> void:
	create_action_list()


func create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.add_theme_font_override("font", font)
		action_label.add_theme_color_override("font_color", font_color)
		action_label.add_theme_font_size_override("font_size", font_size)
		
		input_label.add_theme_font_override("font", font)
		input_label.add_theme_color_override("font_color", font_color)
		input_label.add_theme_font_size_override("font_size", font_size)
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix("(Physical)")
		else:
			input_label.text = ""
			
		action_list.add_child(button)
		button.pressed.connect(on_input_button_pressed.bind(button, action))
		
func on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind..."

func _input(event: InputEvent) -> void:
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
				
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()

func update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix("(Physical)")


func _on_reset_pressed() -> void:
	create_action_list()
