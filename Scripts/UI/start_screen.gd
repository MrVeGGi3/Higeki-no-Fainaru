extends CanvasLayer


@onready var shader_base: EffectsManager = $ShaderBase

@onready var portuguese_button: Button = $VBoxContainer/HBoxContainer/PortugueseButton
@onready var english_button: Button = $VBoxContainer/HBoxContainer/EnglishButton
@onready var japanese_button: Button = $VBoxContainer/HBoxContainer/JapaneseButton

@onready var select_language_label: Label = $VBoxContainer/SelectLanguageLabel
@onready var language_button: AudioStreamPlayer = $LanguageButton







func _ready() -> void:
	_set_label_language_description()
	portuguese_button.mouse_entered.connect(enable_sound)
	japanese_button.mouse_entered.connect(enable_sound)
	english_button.mouse_entered.connect(enable_sound)
	

func enable_sound():
	language_button.play()


func _set_label_language_description():
	var preferred_language = OS.get_locale_language()
	match preferred_language:
		"en":
			select_language_label.text = "Choose your Language"
		"pt":
			select_language_label.text = "Escolha sua Linguagem"
		"ja":
			select_language_label.text = "言語を選択してください"
		_:
			select_language_label.text = "Choose your Language"
			

func _go_to_presentation_screen(language : String):
	TranslationServer.set_locale(language)
	var transition = shader_base.set_effect_shader(EffectsManager.EffectsSettings.FADE_OUT, 0.0, 1.5, 0.0)
	await transition
	get_tree().change_scene_to_file("res://Scenes/PresentationScreen.tscn")
			


func _on_portuguese_button_pressed() -> void:
	_go_to_presentation_screen("pt_BR")


func _on_english_button_pressed() -> void:
	_go_to_presentation_screen("en")


func _on_japanese_button_pressed() -> void:
	_go_to_presentation_screen("ja")
