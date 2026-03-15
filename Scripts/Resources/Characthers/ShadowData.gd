extends CharactherData

@export var portrait_static : Texture


func _init() -> void:
	pt_name = "A Sombra"
	en_name = "The Shadow"
	jp_name = "影"

func _ready() -> void:
	set_actual_name("SHADOW_NAME")
