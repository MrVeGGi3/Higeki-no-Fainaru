extends CanvasLayer

@onready var start_button: Button = $MenuOptions/CenterContainer/VBoxContainer/StartButton
@onready var options_button: Button = $MenuOptions/CenterContainer/VBoxContainer/OptionsButton
@onready var exit_button: Button = $MenuOptions/CenterContainer/VBoxContainer/ExitButton
@onready var press_start: Label = $PressStart
@onready var animations: AnimationPlayer = $Animations
@onready var menu_options: Control = $MenuOptions


func _ready() -> void:
	menu_options.hide()
	start_button.text = tr("START_GAME")	
	options_button.text = tr("OPTIONS_GAME")
	exit_button.text = tr("EXIT_GAME")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainTree.tscn")


func configure_button_with_OS():
	var platform = OS.get_name()
	
	match platform:
		"Android":
			press_start.text = tr("PRESS_START_ANDROID")
		"Windows", "Linux":
			if Input.get_connected_joypads().size() > 0:
				press_start.text = tr("PRESS_START_JOYSTICK")
			else:
				press_start.text = tr("PRESS_START_PC")
			

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("StartGame"):
		animations.play("RESET")
		press_start.hide()
		menu_options.show()
		

		
