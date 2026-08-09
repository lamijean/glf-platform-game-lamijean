extends Button

@export var action_name: String = "move_left"
@export var button_label: String = "Move Left" # Fixed display name

@onready var _pressAnyKey:Panel = $pressAnyKey

var is_remapping: bool = false

func _ready() -> void:
	_pressAnyKey.visible=false
	text = button_label
	update_tooltip()

func _pressed() -> void:
	is_remapping = true
	_pressAnyKey.visible=true

func _unhandled_input(event: InputEvent) -> void:
	if not is_remapping:
		return
	
	if event is InputEventKey and event.is_pressed():
		remap_action(event)
		is_remapping = false
		update_tooltip()
		get_viewport().set_input_as_handled()
		_pressAnyKey.visible=false

func remap_action(new_event: InputEvent) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, new_event)

func update_tooltip() -> void:
	var events = InputMap.action_get_events(action_name)
	if events.size() > 0:
		tooltip_text = "Bound Key: " + events[0].as_text()
	else:
		tooltip_text = "Bound Key: Unassigned"
