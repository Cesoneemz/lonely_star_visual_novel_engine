extends Node
class_name Choices

var _choices: Dictionary
var _text: String
var all_prologue_choices: Dictionary
var button_: Button
var dict_of_buttons: Dictionary

func _init(choices: Dictionary):
	_choices = choices
	

	
func generate_vbox_with_buttons():
	
	for index in _choices:
		dict_of_buttons[index] = Button.new()
		
	var vbox_container: VBoxContainer = VBoxContainer.new()
	vbox_container.set_position(Vector2(250, 250))
	vbox_container.size_flags_horizontal = 0
	vbox_container.rect_size = Vector2(500, 500)
	
	print(get_parent().get_parent().name)
	
	for button in dict_of_buttons:
		dict_of_buttons[button].text = _choices[button]
		dict_of_buttons[button].set("custom_fonts/font", Fonts.load_arkhip_font())
		dict_of_buttons[button].rect_min_size = Vector2(200, 50)
		dict_of_buttons[button].editor_description = button
		dict_of_buttons[button].connect("pressed", get_parent().get_parent(), "switch_current_route", [dict_of_buttons[button]])
		vbox_container.add_child(dict_of_buttons[button])
#		
	
	return vbox_container
