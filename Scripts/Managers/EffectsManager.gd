class_name EffectsManager
extends CanvasLayer

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

@onready var gloom_enviroment: WorldEnvironment = $GloomEnviroment

@onready var fade_rect: ColorRect = $FadeRect
@onready var blur_rect: ColorRect = $BlurRect
@onready var vignette_rect: ColorRect = $VigneteRect
@onready var glitch_rect: ColorRect = $GlitchRect
@onready var chromo_rect: ColorRect = $ChromoRect
@onready var lut_rect: ColorRect = $LUTRect
@onready var screen_shake_rect: ColorRect = $ScreenShakeRect



@onready var effects_rects : Array = [
	fade_rect,
	blur_rect,
	vignette_rect,
	glitch_rect,
	chromo_rect,
]


func set_effect_shader(shader : EffectsSettings, intensity : float, duration : float, s_offset : float):
	match shader:
		EffectsSettings.FADE_IN:
			fade_in(duration)
		EffectsSettings.FADE_OUT:
			fade_out(duration)
		EffectsSettings.SCREEN_SHAKE:
			screen_shake(intensity, duration)
		EffectsSettings.GAUSSIAN_BLUR:
			gaussian_blur(intensity, duration)
		EffectsSettings.BLOOM:
			bloom(intensity, duration)
		EffectsSettings.CHRO_ABERRATION:
			chromatic_aberration(intensity, duration)
		EffectsSettings.GLITCH_EFFECT:
			glitch(intensity, duration)
		EffectsSettings.LUT:
			LUT(duration)
		EffectsSettings.VIGNETTE:
			vignette(s_offset)
		EffectsSettings.EMPTY:
			hide()

func hide_all_rects():
	for effect in effects_rects:
		effect.hide()

func fade_in(duration : float):
	fade_rect.show()
	fade_rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate", Color(fade_rect.modulate, 0.0), duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func(): fade_rect.hide())
	
func fade_out(duration : float):
	fade_rect.show()
	fade_rect.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate",Color(fade_rect.modulate, 1.0), duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func(): fade_rect.hide())
	

func gaussian_blur(intensity : float, duration : float):
	blur_rect.show()
	var material = blur_rect.material
	var tween = create_tween()
	
	tween.tween_property(material, "shader_parameter/amount", intensity, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func(): blur_rect.hide())
	
func bloom(intensity : float, duration : float):
	var env = gloom_enviroment.environment
	var tween = create_tween()
	tween.tween_property(env, "glow_intensity", intensity, duration)	

func hide_fade_rect():
	fade_rect.hide()

func chromatic_aberration(intensity : float, duration : float):
	chromo_rect.show()
	var material = chromo_rect.material
	var tween = create_tween()
	
	tween.tween_property(material, "shader_parameter/offset", intensity, duration / 2)
	tween.tween_property(material, "shader_parameter/offset", 0.1, duration / 2)
	tween.finished.connect(func(): if intensity <= 0: chromo_rect.hide())
	
func glitch(intensity : float, duration : float):
	glitch_rect.show()
	var material = glitch_rect.material
	var tween = create_tween()
	
	tween.tween_property(material, "shader_parameter/range", intensity, 0.05)
	
	tween.tween_property(material, "shader_parameter/range", 0.0, duration)\
		.set_trans(tween.TRANS_QUART)\
		.set_ease(tween.EASE_OUT)
		
	tween.finished.connect(func(): glitch_rect.hide())
	
func LUT(duration : float):
	var material = lut_rect.material
	var tween = create_tween()
	
	tween.tween_property(material, "shader_parameter/strength", 1.0, duration)

func vignette(stress_level : float):
	vignette_rect.show()
	var intensity = lerp(0.2, 0.8, stress_level / 100.0)
	var material = vignette_rect.material
	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/multiplier", intensity, 0.5)

func screen_shake(intensity : float, duration : float):
	screen_shake_rect.show()
	var mat = screen_shake_rect.material
	var tween = create_tween()
	
	tween.tween_property(mat, "shader_parameter/shake_rate", 1.0, 0.1)
	tween.tween_property(mat, "shader_parameter/shake_power", intensity, 0.1)
	
	tween.tween_property(mat, "shader_parameter/shake_rate", 0.0, duration)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
	tween.finished.connect(func(): screen_shake_rect.hide())

	
	
		
		
