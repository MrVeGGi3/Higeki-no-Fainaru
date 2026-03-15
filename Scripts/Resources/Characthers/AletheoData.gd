class_name ProtagonistData
extends CharactherData

@export var portrait_exausted : Texture
@export var portrait_focused : Texture
@export var portrait_neutral : Texture
@export var portrait_shadow : Texture
@export var portrait_skeptical : Texture


func _init():
	en_name = "Emmet"
	jp_name = "真司"
	pt_name = "Aletéo"

func _ready():
	set_actual_name("PROTAGONIST_NAME")
