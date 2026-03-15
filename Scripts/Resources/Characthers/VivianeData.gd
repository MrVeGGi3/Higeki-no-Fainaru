extends CharactherData

@export var portrait_happy : Texture
@export var portrait_determined : Texture
@export var portrait_sad : Texture
@export var portrait_surprised : Texture
@export var portrait_worried : Texture


func _init() -> void:
	pt_name = "Viviana"
	en_name = "Vivienne"
	jp_name = "芽依"
	

func _ready() -> void:
	set_actual_name("HELPER_NAME")
