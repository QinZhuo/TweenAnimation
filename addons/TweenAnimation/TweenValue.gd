@tool
@abstract
class_name TweenValue extends TweenAnimation

@export var final_value: Variant

@export var duration: float = 0.5

@export var transition_type: Tween.TransitionType = Tween.TRANS_SINE

@export var ease_type: Tween.EaseType = Tween.EaseType.EASE_OUT

@export_group("Playback")

@export var from_value: Variant

@export var custom_playback: bool:
	set(value):
		if custom_playback == value:
			return
		custom_playback = value
		notify_property_list_changed()

@export var playback_duration: float = 0.2

@export var playback_transition_type: Tween.TransitionType = Tween.TRANS_SINE

@export var playback_ease_type: Tween.EaseType = Tween.EaseType.EASE_OUT


func _get_tween_from_value():
	return from_value if not is_playback else final_value

func _get_tween_final_value():
	if from_value == null and is_playback:
		from_value = final_value
	return final_value if not is_playback else from_value

func _get_tween_duration() -> float:
	var tween_duration := duration
	if is_playback:
		if custom_playback:
			tween_duration = playback_duration
		else:
			tween_duration /= 2
	return tween_duration

func _set_tweener_curve(tweener: Tweener):
	var is_custom_playback := is_playback and custom_playback
	tweener.set_trans(transition_type if not is_custom_playback else playback_transition_type)
	tweener.set_ease(ease_type if not is_custom_playback else playback_ease_type)

func _validate_property(p: Dictionary):
	var p_name: String = p.name
	if p_name.begins_with("playback_") and not custom_playback:
		p.usage = PROPERTY_USAGE_NO_EDITOR
