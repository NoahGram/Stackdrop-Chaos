extends Camera2D

@onready var camera: Camera2D = $"."
@onready var landing_detector: Area2D = $"../LandingDetector"
@onready var spawner: Node2D = %Spawner
@onready var mountains: Sprite2D = $Background/BackgroundLayer/Mountains
@onready var score_label: Label = $"../../ScoreLabel"

@onready var background: ParallaxBackground = $Background
@onready var background_layer: ParallaxLayer = $Background/BackgroundLayer
@onready var skybox: Sprite2D = $Background/BackgroundLayer/Skybox

var shake_amount: float = 0.0
var shake_decay: float = 5.0

var block_left = false

func _process(delta):
	if Input.is_action_pressed("ui_page_up"):
		print("Up")
		camera.position.y -= 200 * delta
	elif Input.is_action_pressed("ui_page_down"):
		print("Down")
		camera.position.y += 200 * delta
		
	if shake_amount > 0:
		offset = Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		) * shake_amount
		shake_amount = max(shake_amount - shake_decay * delta, 0)
	else:
		offset = Vector2.ZERO


func _on_camera_increase(body: RigidBody2D) -> void:
	block_left = false
	if camera == null:
		print("Camera not found!")
		return


	if not body.is_active: 
		await get_tree().create_timer(1).timeout # Object Falling Through Not Stopped
		if not block_left:
			print("Landed block detected - Moving camera up")
			var tween : Tween = self.create_tween()
			tween.tween_property(camera, "global_position:y", camera.global_position.y - 100, 0.0)
			tween.parallel().tween_property(skybox, "global_position:y", skybox.global_position.y - 100, 0.0)
			tween.parallel().tween_property(landing_detector, "global_position:y", landing_detector.global_position.y - 100, 0.0)
			tween.parallel().tween_property(score_label, "global_position:y", score_label.global_position.y - 100, 0.0)
			spawner.spawn_position += Vector2(0, -100)


func _on_camera_decrease(body: Node2D) -> void:
	block_left = true


func start_shake(amount: float) -> void:
	shake_amount = amount
