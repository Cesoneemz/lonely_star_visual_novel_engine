extends Node
class_name Dialog

var transition: Transitions = Transitions.new()

var _text_label: RichTextLabel
var _name_label: Label
var _tween: Tween
var _dialogue_index: int = 0
var _dialog_box: TextureRect
var _choices
var is_dialog_active: bool = true
var current_route: String = 'Main'


func _init(text_label: RichTextLabel, name_label: Label, tween: Tween, dialog_box: TextureRect, choices: Object):
	_text_label = text_label
	_name_label = name_label
	_name_label.modulate = Color(1,1,1,0)
	_tween = tween
	_dialog_box = dialog_box
	_choices = choices
	_dialog_box.modulate = Color(1,1,1,0)
	

func _is_dialogs_end(dialogue_index: int, dialogue_size: int) -> bool:
	return dialogue_index < dialogue_size
	

func load_dialogue(dialogue: Array):
	if _is_dialogs_end(_dialogue_index, dialogue.size()):
		
		if _dialog_box.visible == false:
			_dialog_box.visible = true
			_tween.interpolate_property(_dialog_box, "modulate",
				Color(1,1,1,0), Color(1,1,1,1), 0.8, _tween.TRANS_LINEAR, _tween.EASE_IN)
			_tween.start()
		
		
		if not dialogue[_dialogue_index]["Choices"].empty():
			
			var buttons_generator: Choices = _choices.new(dialogue[_dialogue_index]['Choices'])
			self.add_child(buttons_generator)
			var generated_buttons: VBoxContainer = buttons_generator.generate_vbox_with_buttons()
			
			self.add_child(generated_buttons)
			
			
			var choices_title = Label.new()
			choices_title.text = dialogue[_dialogue_index]["Text"]
			choices_title.set("custom_fonts/font", Fonts.load_arkhip_font()) 
			choices_title.align = 1
			
			generated_buttons.add_child(choices_title)
			
			_tween.interpolate_property(_dialog_box, "modulate",
				Color(1,1,1,1), Color(1,1,1,0), 0.1, _tween.TRANS_LINEAR, _tween.EASE_OUT)
			_tween.interpolate_property(generated_buttons, "modulate",
				Color(1,1,1,0), Color(1,1,1,1), 0.1, _tween.TRANS_LINEAR, _tween.EASE_OUT)
				
			_dialog_box.visible = 0
			_dialogue_index = 0
				
			_tween.start()
			
			return
			
			
			
		
		if _dialog_box.modulate == Color(1,1,1,0):
			_tween.interpolate_property(_dialog_box, "modulate",
				Color(1,1,1,0), Color(1,1,1,1), 0.8, _tween.TRANS_LINEAR, _tween.EASE_IN)
			_tween.start()
			
		
		_text_label.bbcode_text = dialogue[_dialogue_index]["Text"]
		_name_label.text = dialogue[_dialogue_index]["Name"]
		_text_label.percent_visible = 0
		
		if _name_label.modulate == Color(1,1,1,0):
			_tween.interpolate_property(_name_label, "modulate",
				Color(1,1,1,0), Color(1,1,1,1), 1.0, _tween.TRANS_LINEAR, _tween.EASE_IN)
		_tween.interpolate_property(_text_label, "percent_visible", 0, 1, 1, 
			_tween.TRANS_LINEAR, _tween.EASE_IN_OUT)
		_tween.start()
		
	else:
		
		_tween.interpolate_property(_dialog_box, "modulate",
			Color(1,1,1,1), Color(1,1,1,0), 0.8, _tween.TRANS_LINEAR, _tween.EASE_OUT)
		_tween.interpolate_property(_name_label, "modulate",
			Color(1,1,1,1), Color(1,1,1,0), 0.8, _tween.TRANS_LINEAR, _tween.EASE_OUT)
		_tween.interpolate_property(_text_label, "modulate",
			Color(1,1,1,1), Color(1,1,1,0), 0.8, _tween.TRANS_LINEAR, _tween.EASE_OUT)
			
		_tween.start()
		
		is_dialog_active = false
		
	_dialogue_index += 1


