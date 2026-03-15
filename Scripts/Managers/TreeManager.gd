class_name TreeManager
extends Control

@onready var background_placement: BackgroundPlacement = $BackgroundPlacement
@onready var characther_placement: CharScreenManager = $CharactherPlacement
@onready var dialogue_box: DialogueManager = $DialogueBox
@onready var shader_base: EffectsManager = $ShaderBase
@onready var investigation_box: InvestigationManager = $InvestigationBox

@export var target_act_node : LevelEditor

func _ready() -> void:
	await background_placement.ready
	await characther_placement.ready
	await dialogue_box.ready
	target_act_node.start_pipeline()
	
