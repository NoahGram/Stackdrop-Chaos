extends Control

@onready var score_list: VBoxContainer = $ScoreList

var font = preload("res://assets/fonts/PixelOperator8.ttf")
var font_color = Color("White")
var font_size = 24
var scores

func _ready() -> void:
	show_scores()

func show_scores():
	for child in score_list.get_children():
		child.queue_free()

	scores = SaveManager.high_scores

	if scores.size() == 0:
		var row = HBoxContainer.new()
		var rank_label = Label.new()
		rank_label.text = "No Entries Yet"
		rank_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		rank_label.custom_minimum_size.x = 30
		rank_label.add_theme_font_override("font", font)
		rank_label.add_theme_color_override("font_color", font_color)
		rank_label.add_theme_font_size_override("font_size", font_size)

		row.add_child(rank_label)
		score_list.add_child(row)
		return

	for i in scores.size():
		var score = scores[i]

		var row = HBoxContainer.new()

		var rank_label = Label.new()
		rank_label.text = "%d." % (i + 1)
		rank_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		rank_label.custom_minimum_size.x = 30
		rank_label.add_theme_font_override("font", font)
		rank_label.add_theme_color_override("font_color", font_color)
		rank_label.add_theme_font_size_override("font_size", font_size)

		var score_label = Label.new()
		score_label.text = "%d points" % score
		score_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		score_label.add_theme_font_override("font", font)
		score_label.add_theme_color_override("font_color", font_color)
		score_label.add_theme_font_size_override("font_size", font_size)

		row.add_child(rank_label)
		row.add_child(score_label)

		score_list.add_child(row)


func _on_back_to_titlescreen_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/titlescreen.tscn")


func _on_clear_save_data_pressed() -> void:
	SaveManager.clear_save_data()
	show_scores()
