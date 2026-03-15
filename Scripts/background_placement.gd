class_name  BackgroundPlacement
extends CanvasLayer

@onready var background_rect: TextureRect = $BackgroundRect

func change_background(texture : Texture):
	background_rect.texture = texture
	
