@tool
class_name TweenCallback extends TweenAnimation

signal tween_callback

func _create_tweenr(root_tween: Tween):
	root_tween.tween_callback(tween_callback.emit)
	super._create_tweenr(root_tween)
