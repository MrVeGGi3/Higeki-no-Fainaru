@abstract
class_name CharactherData
extends Resource

@export_group("Identidade")
@export var pt_name : String
@export var en_name : String
@export var jp_name : String
var actual_name


func set_actual_name(key : String):
	actual_name = tr(key)
	
