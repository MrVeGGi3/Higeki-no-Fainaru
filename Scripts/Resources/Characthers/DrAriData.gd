extends CharactherData

@export var portrait_calm : Texture
@export var portrait_judgement : Texture
@export var portrait_misterious : Texture
@export var portrait_restrictive : Texture


func _init() -> void:
	pt_name = "Doutor Ari"
	en_name = "Dr. Aris"
	jp_name = "アリス博士"

func _ready() -> void:
	set_actual_name("MENTOR_NAME")
