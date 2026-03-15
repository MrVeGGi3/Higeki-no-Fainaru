@abstract
class_name LevelEditor
extends Node

@export var background_placement : BackgroundPlacement
@export var characther_placement : CharScreenManager
@export var dialogue_box : DialogueManager
@export var shader_base : EffectsManager
@export var investigation_box : InvestigationManager


@export var background_res : BackgroundResource

var aletheo_resource_speech : Resource
var vivianve_resource_speech : Resource
var doctor_resource_speech : Resource
var shadow_resource_speech : Resource

var actual_expression
var actual_position

var mode_setter : CharScreenManager.PortraitMode

enum PortraitMode {
	UNIQUE, 
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

enum TextVelocity {SLOW, MEDIUM, FAST, ULTRAFAST, INSTANT}

enum AletheoExpressions {EXAUSTED, FOCUSED, NEUTRAL, SHADOW, SKEPTICAL, EMPTY}
enum VivianeExpressions {HAPPY, DETERMINED, SURPRISED, WORRIED, EMPTY}
enum ShadowExpressions {STATIC,EMPTY}
enum DoctorExpressions {CALM, JUDGE, MISTERIOUS, RESTRICTED, EMPTY}


enum EffectsSettings {
	FADE_IN,
	FADE_OUT,
	SCREEN_SHAKE,
	GAUSSIAN_BLUR,
	BLOOM,
	CHRO_ABERRATION,
	GLITCH_EFFECT,
	LUT,
	VIGNETTE,
	EMPTY
}


func change_background_to(back_name : String):
	if background_res.backgrounds.has(back_name):
		var texture = background_res.backgrounds[back_name]
		if texture:
			dialogue_box.dialogue_spliter.add_background(texture)
		else:
			push_warning("Aviso: Textura está vazia!")
	else:
		push_error("Erro: O nome '" + back_name + " ' não existe no dicionário de backgrounds!")

func set_screen_mode(mode : PortraitMode):
	var actual_mode
	match mode:
		PortraitMode.UNIQUE:
			actual_mode = characther_placement.PortraitMode.UNIQUE
		PortraitMode.DOUBLE:
			actual_mode = characther_placement.PortraitMode.DOUBLE
		PortraitMode.THREE:
			actual_mode = characther_placement.PortraitMode.THREE
		PortraitMode.HIDE:
			actual_mode = characther_placement.PortraitMode.HIDE
		
		
	characther_placement.set_screen_mode(actual_mode)

func add_aletheo_speech(char_express : AletheoExpressions, char_pos : CharactherPos, text : String):

	match char_express:
		AletheoExpressions.EXAUSTED:
			actual_expression = CharScreenManager.AletheoExpressions.EXAUSTED
		AletheoExpressions.FOCUSED:
			actual_expression = CharScreenManager.AletheoExpressions.FOCUSED
		AletheoExpressions.NEUTRAL:
			actual_expression = CharScreenManager.AletheoExpressions.NEUTRAL
		AletheoExpressions.SHADOW:
			actual_expression = CharScreenManager.AletheoExpressions.SHADOW
		AletheoExpressions.SKEPTICAL:
			actual_expression = CharScreenManager.AletheoExpressions.SKEPTICAL
		AletheoExpressions.EMPTY:
			actual_expression = CharScreenManager.AletheoExpressions.EMPTY
	
	match char_pos:
		CharactherPos.UNIQUE:
			actual_position = CharScreenManager.CharactherPos.UNIQUE
		CharactherPos.DOUBLE_LEFT:
			actual_position = CharScreenManager.CharactherPos.DOUBLE_LEFT
		CharactherPos.DOUBLE_RIGHT:
			actual_position = CharScreenManager.CharactherPos.DOUBLE_RIGHT
		CharactherPos.TRIPLE_LEFT:
			actual_position = CharScreenManager.CharactherPos.TRIPLE_LEFT
		CharactherPos.TRIPLE_MID:
			actual_position = CharScreenManager.CharactherPos.TRIPLE_MID
		CharactherPos.TRIPLE_RIGHT:
			actual_position = CharScreenManager.CharactherPos.TRIPLE_RIGHT
			

			
	characther_placement.add_aletheo_expression(actual_expression, actual_position)
	dialogue_box.dialogue_spliter.add_speech(tr("PROTAGONIST_NAME"), text)

func add_viviane_speech(char_express : VivianeExpressions, char_pos : CharactherPos,  text : String):
	
	match char_express:
		VivianeExpressions.HAPPY:
			actual_expression = CharScreenManager.VivianeExpressions.HAPPY
		VivianeExpressions.DETERMINED:
			actual_expression = CharScreenManager.VivianeExpressions.DETERMINED
		VivianeExpressions.SURPRISED:
			actual_expression = CharScreenManager.VivianeExpressions.SURPRISED
		VivianeExpressions.WORRIED:
			actual_expression = CharScreenManager.VivianeExpressions.WORRIED
		VivianeExpressions.EMPTY:
			actual_expression = CharScreenManager.VivianeExpressions.EMPTY
			
			
	match char_pos:
		CharactherPos.UNIQUE:
			actual_position = CharScreenManager.CharactherPos.UNIQUE
		CharactherPos.DOUBLE_LEFT:
			actual_position = CharScreenManager.CharactherPos.DOUBLE_LEFT
		CharactherPos.DOUBLE_RIGHT:
			actual_position = CharScreenManager.CharactherPos.DOUBLE_RIGHT
		CharactherPos.TRIPLE_LEFT:
			actual_position = CharScreenManager.CharactherPos.TRIPLE_LEFT
		CharactherPos.TRIPLE_MID:
			actual_position = CharScreenManager.CharactherPos.TRIPLE_MID
		CharactherPos.TRIPLE_RIGHT:
			actual_position = CharScreenManager.CharactherPos.TRIPLE_RIGHT
			
	characther_placement.add_viviane_expression(actual_expression, actual_position)
	dialogue_box.dialogue_spliter.add_speech(tr("HELPER_NAME"), text)
	
func add_doctor_speech(char_express : DoctorExpressions, char_pos : CharactherPos, text : String):
	
	match char_express:
		DoctorExpressions.CALM:
			actual_expression =  CharScreenManager.DoctorExpressions.CALM
		DoctorExpressions.JUDGE:
			actual_expression =  CharScreenManager.DoctorExpressions.JUDGE
		DoctorExpressions.MISTERIOUS:
			actual_expression =  CharScreenManager.DoctorExpressions.MISTERIOUS
		DoctorExpressions.RESTRICTED:
			actual_expression =  CharScreenManager.DoctorExpressions.RESTRICTED
		DoctorExpressions.EMPTY:
			actual_expression =  CharScreenManager.DoctorExpressions.EMPTY
	
	match char_pos:
		CharactherPos.UNIQUE:
			actual_position = CharScreenManager.CharactherPos.UNIQUE
		CharactherPos.DOUBLE_LEFT:
			actual_position = CharScreenManager.CharactherPos.DOUBLE_LEFT
		CharactherPos.DOUBLE_RIGHT:
			actual_position = CharScreenManager.CharactherPos.DOUBLE_RIGHT
		CharactherPos.TRIPLE_LEFT:
			actual_position = CharScreenManager.CharactherPos.TRIPLE_LEFT
		CharactherPos.TRIPLE_MID:
			actual_position = CharScreenManager.CharactherPos.TRIPLE_MID
		CharactherPos.TRIPLE_RIGHT:
			actual_position = CharScreenManager.CharactherPos.TRIPLE_RIGHT
	
	
	characther_placement.add_doctor_expression(actual_expression, actual_position)
	dialogue_box.dialogue_spliter.add_speech(tr("MENTOR_NAME") , text)

func set_effect(effect : EffectsSettings, intensity : float, duration : float, offset : float):
	var actual_effect
	match effect:
		EffectsSettings.FADE_IN:
			actual_effect = EffectsManager.EffectsSettings.FADE_IN
		EffectsSettings.FADE_OUT:
			actual_effect = EffectsManager.EffectsSettings.FADE_OUT
		EffectsSettings.SCREEN_SHAKE:
			actual_effect = EffectsManager.EffectsSettings.SCREEN_SHAKE
		EffectsSettings.GAUSSIAN_BLUR:
			actual_effect = EffectsManager.EffectsSettings.GAUSSIAN_BLUR
		EffectsSettings.BLOOM:
			actual_effect = EffectsManager.EffectsSettings.BLOOM
		EffectsSettings.CHRO_ABERRATION:
			actual_effect = EffectsManager.EffectsSettings.CHRO_ABERRATION
		EffectsSettings.GLITCH_EFFECT:
			actual_effect = EffectsManager.EffectsSettings.GLITCH_EFFECT
		EffectsSettings.LUT:
			actual_effect = EffectsManager.EffectsSettings.LUT
		EffectsSettings.VIGNETTE:
			actual_effect = EffectsManager.EffectsSettings.VIGNETTE
		EffectsSettings.EMPTY:
			actual_effect = EffectsManager.EffectsSettings.EMPTY
	

	dialogue_box.dialogue_spliter.add_effect(actual_effect, intensity, duration, offset)


func start_pipeline():
	pass
