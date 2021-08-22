extends Node

onready var text_label: RichTextLabel = $TextureRect/TextLabel
onready var name_label: Label = $TextureRect/Name
onready var tween: Tween = $TextureRect/Tween
onready var dialog_box: TextureRect = $TextureRect

var DialogClass = preload("res://Scripts/Dialogue.gd")

onready var prologue_dialog = preload("res://Scenario/Prologue.gd").new()
onready var choices = preload("res://Scripts/Choices.gd")
onready var dialog: Dialog = DialogClass.new(text_label, name_label, tween, dialog_box, choices)

var current_route: String = 'Main'
var on_choice: bool = false

func _ready():
	add_child(dialog)
	dialog.load_dialogue(prologue_dialog.dialog[0]['Main'])
	
func _physics_process(delta):
	if dialog.is_dialog_active:
		
		if Input.is_action_just_pressed("ui_accept") or on_choice:
			if on_choice:
				on_choice = false
			dialog.load_dialogue(prologue_dialog.dialog[0][current_route])
			

func _get_all_routes() -> Array:
	var all_routes = (prologue_dialog.dialog[0].keys())
	return all_routes
	
func switch_current_route(choice: Button) -> void:
	
	var all_routes: Array = _get_all_routes()
	
	if choice.editor_description in all_routes:
		current_route = choice.editor_description
	
	choice.get_parent().queue_free()
	
	on_choice = true
	

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
