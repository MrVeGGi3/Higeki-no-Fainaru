class_name CharScreenManager
extends CanvasLayer

@export_category("Chacthers Resources")
const ALETHEO_DATA = preload("uid://c1vquw3u6sdb8")
const MENTOR_DATA = preload("uid://drv72lawmy70r")
const SHADOW_DATA = preload("uid://dl0uxlcfjw3o1")
const VIVIANE_DATA = preload("uid://dxmaeiwow0tne")


@export_category("Sizes")
@export var three_normal_size : Vector2 = Vector2(762.0, 762.0)
@export var dual_normal_size : Vector2 = Vector2(942.0, 942.0)
@export var one_normal_size : Vector2 = Vector2(1073.6, 1073.6)

@export_category("Char Texture")
@onready var char_portrait_1 : TextureRect = $Players/Characther1
@onready var char_portrait_2 : TextureRect = $Players/Characther2
@onready var char_protrait_3 : TextureRect = $Players/Characther3

@export_category("Three_Char_Markers")
@onready var tcm_1 : Marker2D = $"TexturePlacementMarkers/ThreeCharMode/1"
@onready var tcm_2 : Marker2D = $"TexturePlacementMarkers/ThreeCharMode/2"
@onready var tcm_3 : Marker2D = $"TexturePlacementMarkers/ThreeCharMode/3"

@export_category("Double_Char_Markers")
@onready var dcm_1 : Marker2D = $"TexturePlacementMarkers/DoubleCharMode/1"
@onready var dcm_2 : Marker2D = $"TexturePlacementMarkers/DoubleCharMode/2"

@export_category("One Char Marker")
@onready var unique_char_marker : Marker2D = $"TexturePlacementMarkers/OneCharMode/1"

@export_category("Setters")
enum PortraitMode {UNIQUE, 
	DOUBLE, 
	THREE,
	HIDE
}

enum CharactherPos {
	UNIQUE,
	DOUBLE_LEFT,
	DOUBLE_RIGHT,
	TRIPLE_LEFT,
	TRIPLE_MID,
	TRIPLE_RIGHT,
}

var actual_mode : PortraitMode

@export_category("Char Expressions")
enum AletheoExpressions {EXAUSTED, FOCUSED, NEUTRAL, SHADOW, SKEPTICAL, EMPTY}
enum VivianeExpressions {HAPPY, DETERMINED, SURPRISED, WORRIED, EMPTY}
enum ShadowExpressions {STATIC,EMPTY}
enum DoctorExpressions {CALM, JUDGE, MISTERIOUS, RESTRICTED, EMPTY}

func set_screen_mode(mode : PortraitMode):
	match mode:
		PortraitMode.UNIQUE:
			set_unique_char_mode()
			actual_mode = PortraitMode.UNIQUE
		PortraitMode.DOUBLE:
			set_double_char_mode()
			actual_mode = PortraitMode.DOUBLE
		PortraitMode.THREE:
			set_triple_char_mode()
			actual_mode = PortraitMode.THREE
		PortraitMode.HIDE:
			set_hide_char_mode()
			actual_mode = PortraitMode.HIDE
		_:
			return
		
func add_aletheo_expression(expression : AletheoExpressions, char_pos : CharactherPos):
	var actual_texture
	match expression:
		AletheoExpressions.EXAUSTED:
			actual_texture = ALETHEO_DATA.portrait_exausted
		AletheoExpressions.FOCUSED:
			actual_texture = ALETHEO_DATA.portrait_focused
		AletheoExpressions.NEUTRAL:
			actual_texture = ALETHEO_DATA.portrait_neutral
		AletheoExpressions.SHADOW:
			actual_texture = ALETHEO_DATA.portrait_shadow
		AletheoExpressions.SKEPTICAL:
			actual_texture = ALETHEO_DATA.portrait_skeptical
		AletheoExpressions.EMPTY:
			actual_texture = null
	
	see_mode_to_set_texture(char_pos, actual_texture)

func add_doctor_expression(expression : DoctorExpressions, char_pos: CharactherPos):
	var actual_texture
	match expression:
		DoctorExpressions.CALM:
			actual_texture = MENTOR_DATA.portrait_calm
		DoctorExpressions.JUDGE:
			actual_texture = MENTOR_DATA.portrait_judgement
		DoctorExpressions.MISTERIOUS:
			actual_texture = MENTOR_DATA.portrait_misterious
		DoctorExpressions.RESTRICTED:
			actual_texture = MENTOR_DATA.portrait_restrictive
		_:
			return
	
	see_mode_to_set_texture(char_pos, actual_texture)

func add_viviane_expression(expression : VivianeExpressions, char_pos : CharactherPos):
	var actual_texture
	match expression:
		VivianeExpressions.HAPPY:
			actual_texture = VIVIANE_DATA.portrait_happy
		VivianeExpressions.DETERMINED:
			actual_texture = VIVIANE_DATA.portrait_determined
		VivianeExpressions.SURPRISED:
			actual_texture = VIVIANE_DATA.portrait_surprised
		VivianeExpressions.WORRIED:
			actual_texture = VIVIANE_DATA.portrait_worried
	
	see_mode_to_set_texture(char_pos, actual_texture)
		


func set_image_into_texture(texture_index : CharactherPos, image_texture : Texture):
	match texture_index:
		CharactherPos.UNIQUE, CharactherPos.DOUBLE_LEFT:
			char_portrait_1.texture = image_texture
		CharactherPos.DOUBLE_RIGHT, CharactherPos.TRIPLE_MID:
			char_portrait_2.texture = image_texture
		CharactherPos.TRIPLE_RIGHT:
			char_protrait_3.texture = image_texture
		_:
			return
	
func set_unique_char_mode():
	char_portrait_1.show()
	char_portrait_2.hide()
	char_protrait_3.hide()
	char_portrait_1.position = unique_char_marker.position
	char_portrait_1.size = one_normal_size

func set_double_char_mode():
	char_portrait_1.show()
	char_portrait_2.show()
	char_protrait_3.hide()
	char_portrait_1.position = dcm_1.position
	char_portrait_2.position = dcm_2.position
	char_portrait_1.size = dual_normal_size
	char_portrait_2.size = dual_normal_size

func set_triple_char_mode():
	char_portrait_1.show()
	char_portrait_2.show()
	char_protrait_3.show()
	char_portrait_1.position = tcm_1.position
	char_portrait_2.position = tcm_2.position
	char_protrait_3.position = tcm_3.position
	char_portrait_1.size = three_normal_size
	char_portrait_2.size = three_normal_size
	char_protrait_3.size = three_normal_size

func set_hide_char_mode():
	char_portrait_1.hide()
	char_portrait_2.hide()
	char_protrait_3.hide()


func see_mode_to_set_texture(text_pos : CharactherPos, texture : Texture):
	match actual_mode:
		PortraitMode.UNIQUE:
			if text_pos == CharactherPos.UNIQUE:
				set_image_into_texture(text_pos, texture)
			else:
				push_error("Modo Errado!")
		PortraitMode.DOUBLE:
			match text_pos:
				CharactherPos.DOUBLE_LEFT, CharactherPos.DOUBLE_RIGHT:
					set_image_into_texture(text_pos, texture)
				_:
					push_error("Modo Errado!")
			
		PortraitMode.THREE:
			match text_pos:
				CharactherPos.TRIPLE_LEFT, CharactherPos.TRIPLE_MID, CharactherPos.TRIPLE_RIGHT:
					set_image_into_texture(text_pos, texture)
				_:
					push_error("Modo Errado!")
			
		PortraitMode.HIDE:
			push_error("Mude de modo para acrescentar o player")
		
		_:
			return
