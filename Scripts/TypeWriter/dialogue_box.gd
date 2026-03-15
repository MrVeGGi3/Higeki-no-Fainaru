class_name DialogueManager
extends CanvasLayer

@export var dialogue_spliter : DialogueSpliter
@export var background_placement : BackgroundPlacement
@export var shader_base : EffectsManager
@onready var dialog_box_elements : Control = $DialogElements


func _ready() -> void:
	dialogue_spliter.background_placement = background_placement
	dialogue_spliter.shader_base = shader_base

func hide_dialog_box():
	dialog_box_elements.hide()
