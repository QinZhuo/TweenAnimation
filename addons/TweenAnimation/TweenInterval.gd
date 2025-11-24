@tool
class_name TweenInterval extends TweenAnimation
@export var time: float

func _create_tweenr(root_tween: Tween):
	root_tween.tween_interval(time)
	super._create_tweenr(root_tween)
