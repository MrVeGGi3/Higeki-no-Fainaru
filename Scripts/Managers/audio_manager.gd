class_name AudioManager
extends Node

@onready var aletheo_stream_player: AudioStreamPlayer = $"../AletheoStreamPlayer"
@onready var viviane_stream_player: AudioStreamPlayer = $"../VivianeStreamPlayer"
@onready var doctor_stream_player: AudioStreamPlayer = $"../DoctorStreamPlayer"
@onready var shadow_stream_player: AudioStreamPlayer = $"../ShadowStreamPlayer"

@onready var  actual_stream_player : AudioStreamPlayer



func play_voice_localized(key : String, char_name : String):
	match char_name:
		"Aletéo", "Emmet", "真司":
			actual_stream_player = aletheo_stream_player
		"Viviana", "Vivienne", "芽依" :
			actual_stream_player = viviane_stream_player
		"Doutor Ari", "Dr. Aris", "アリス博士":
			actual_stream_player = doctor_stream_player
		"A Sombra", "The Shadow", "影":
			actual_stream_player = shadow_stream_player
		_:
			return
			
	var current_locale = TranslationServer.get_locale()
	
	var path = "res://Speeches/" + current_locale + "/" + key + ".mp3"
	
	
	
	if FileAccess.file_exists(path):
		var speech = load(path)
		actual_stream_player.stream = speech
		actual_stream_player.play()
	else:
		push_warning("Áudio não encontrado para a chave")
		
