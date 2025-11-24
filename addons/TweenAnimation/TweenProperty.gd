@tool
class_name TweenProperty extends TweenValue

@export var node: Node:
	get():
		if not node:
			var parent = get_parent()
			while parent is TweenAnimation:
				parent = parent.get_parent()
			node = parent
		return node

@export var property: String = "position:x"

static var popup_property_selector: RefCounted:
	get():
		if not popup_property_selector:
			var script = GDScript.new()
			script.source_code = "
extends EditorScript
var node:Node
var callback:Callable
func run():
	EditorInterface.popup_property_selector(node, callback)
			"
			script.reload()
			popup_property_selector = script.new()
		return popup_property_selector

@export_tool_button("Select Property") var select_property := func():
	if Engine.is_editor_hint():
		popup_property_selector.node = node
		popup_property_selector.callback = func(property_path):
			if property_path:
				property = property_path
				final_value = node.get_indexed(property)
				from_value = node.get_indexed(property)
				print(final_value)
				notify_property_list_changed()
		popup_property_selector.run()

func _create_tweenr(tween: Tween):
	_set_tweener_curve(tween.tween_property(node, property, _get_tween_final_value(), _get_tween_duration()))
	super._create_tweenr(tween)
