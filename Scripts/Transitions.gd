extends Object
class_name Transitions



static func tween_dissolve_transition(obj: Object, tween: Tween, transition_type: String, initial_val, final_val, duration: float, transtype, easetype):
	print(initial_val, final_val)
	tween.interpolate_property(
		obj, transition_type, initial_val, final_val, duration,
		transtype, easetype
	)
	tween.start()
