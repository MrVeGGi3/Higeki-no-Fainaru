extends CanvasLayer

@onready var label_animation: AnimationPlayer = $LabelAnimation
@onready var shader_base: EffectsManager = $ShaderBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_animation.play("Title")



func _on_video_stream_player_finished() -> void:
	var transition = shader_base.set_effect_shader(shader_base.EffectsSettings.FADE_OUT, 0.0, 2.0, 0.0)
	await transition
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
