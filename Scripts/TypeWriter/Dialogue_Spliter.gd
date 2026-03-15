class_name DialogueSpliter
extends Node

@export_category("Text Speeds")
@export var slow_velocity = 2.0
@export var medium_velocity = 4.0
@export var fast_velocity = 8.0
@export var ultrafast_velocity = 12.0
@export var dialogue_box : RichTextLabel
@export var audio_manager : AudioManager 

@onready var char_name_label: Label = $"../DialogElements/DialogueBox/CharNameLabel"
@onready var next_speech_audio: AudioStreamPlayer = $"../NextSpeechAudio"

@onready var aletheo_stream_player: AudioStreamPlayer = $"../AletheoStreamPlayer"
@onready var viviane_stream_player: AudioStreamPlayer = $"../VivianeStreamPlayer"
@onready var doctor_stream_player: AudioStreamPlayer = $"../DoctorStreamPlayer"
@onready var shadow_stream_player: AudioStreamPlayer = $"../ShadowStreamPlayer"



var background_placement : BackgroundPlacement
var actual_stream_player : AudioStreamPlayer
var actual_text : String 
var total_text : String
var is_typing : bool
var actual_background : Texture
var actual_tween : Tween
var shader_base : EffectsManager


enum TextVelocity {SLOW, MEDIUM, FAST, ULTRAFAST, INSTANT}


var text_letter_strings : Array = []

var dialogue_queue : Array = []
var effects_queue : Array = []
var background_queue : Array = []


var is_waiting_input : bool


func add_speech(char_name: String, key: String):
	dialogue_queue.append({
		"char_name": char_name,
		"key": key,
		"stream_player": actual_stream_player
	})
	if not is_typing and not is_waiting_input:
		_run_next_dialogue()

func add_effect(shader : EffectsManager.EffectsSettings, intensity: float, duration : float, offset : float):
	effects_queue.append({
		"effect": shader,
		"intensity": intensity,
		"duration": duration,
		"offset": offset	
	})
	
func add_background(background : Texture):
	background_queue.append(background)


func _run_next_dialogue():
	if dialogue_queue.is_empty():
		return
	
	var current_data = dialogue_queue.pop_front()
	var current_effect = effects_queue.pop_front()
	var current_background = background_queue.pop_front()
	
	
	audio_manager.play_voice_localized(current_data["key"], current_data["char_name"])
	
	var duration = 0.0
	if audio_manager.actual_stream_player.stream:
		duration = audio_manager.actual_stream_player.stream.get_length()
	
	clear_dialogue()
	
	shader_base.set_effect_shader(current_effect["effect"], 
		current_effect["intensity"], 
		current_effect["duration"], 
		current_effect["offset"]
	)
	
	background_placement.change_background(current_background)
	
	scroll_actual_phrase(
		current_data["char_name"],
		current_data["key"],
		duration
	)


func scroll_actual_phrase(char_name : String , key : String, duration : float):
	actual_text = tr(key)
	char_name_label.text = char_name
	dialogue_box.show()
		
	total_text += actual_text + "\n"
	dialogue_box.text = total_text
	
	var start_index = dialogue_box.get_total_character_count() - actual_text.length() - 1
	var end_index = dialogue_box.get_total_character_count()
	
	dialogue_box.visible_characters = start_index
	actual_tween = create_tween()
	is_typing = true
	
	actual_tween.tween_property(
		dialogue_box,
		"visible_characters",
		end_index,
		duration
	).set_trans(Tween.TRANS_LINEAR)
	
	actual_tween.finished.connect(func(): 
		is_typing = false
		is_waiting_input = true
	)
	return actual_tween.finished
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed):
		next_speech_audio.play()
		if is_typing:
			_skip_typewriter()
			is_waiting_input = true
		elif is_waiting_input:
			is_waiting_input = false
			_run_next_dialogue()
		
func _skip_typewriter():
	if actual_tween and actual_tween.is_running:
		audio_manager.actual_stream_player.stop()
		actual_tween.kill()
		dialogue_box.visible_characters = -1
		is_typing = false

func clear_dialogue():
	if is_instance_valid(actual_tween) and actual_tween.is_running():
		actual_tween.kill()
	
	is_typing = false
	actual_text = ""
	total_text = ""
	text_letter_strings.clear()
	
	if dialogue_box:
		dialogue_box.text = ""
		dialogue_box.visible_characters = -1
	
