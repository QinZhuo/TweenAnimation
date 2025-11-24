@tool
class_name TweenMethod extends TweenValue

signal tween_method(value)

func _create_tweenr(tween: Tween):
	_set_tweener_curve(tween.tween_method(tween_method.emit, _get_tween_from_value(), _get_tween_final_value(), _get_tween_duration()))
	super._create_tweenr(tween)
