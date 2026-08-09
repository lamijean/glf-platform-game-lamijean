extends Control
class_name HudPlatform

@onready var icons:Control=get_node("CanvasLayer/icons")

signal player_select_magic_stick
signal player_select_magic_freeze
signal player_select_magic_fire

const MAGIC_STICK ='MagicStick'
const MAGIC_FREEZE ='MagicFreeze'
const MAGIC_FIRE ='MagicFire'

var numberOfIconEnabled:int=0

const iconMargin:int=2

@onready var _lifeIcon=$CanvasLayer/lifes/life

@onready var _lifes=$CanvasLayer/lifes

var _lifeIconBase=null

func _ready() -> void:
	for iconLoop:Control in icons.get_children():
		iconLoop.visible=false

func build_lifes(number:int):
	for i in range(number):
		var new_life = _lifeIcon.duplicate()
		new_life.position.x += i * 10
		_lifes.add_child(new_life)

func update_life(number:int):
	var i=0
	for child:AnimatedSprite2D in _lifes.get_children():
		if i<=number:
			child.visible=true
		else:
			if(number==i-1):
				child.play()
				await child.animation_finished
				#await get_tree().create_timer(0.8).timeout
			child.visible=false
		i+=1
	

func enableIcon(icon:String):
	unselect_all_icons()
	for iconLoop:Control in icons.get_children():
		if iconLoop.name==icon:
			
			iconLoop.visible=true
			iconLoop.select()
			iconLoop.position.x=16*numberOfIconEnabled
			iconLoop.position+=Vector2(iconMargin,iconMargin)
			
			numberOfIconEnabled+=1

func select_icon(icon:String):
	unselect_all_icons()
	for iconLoop:Control in icons.get_children():
		if iconLoop.name==icon:
			iconLoop.select()
 
func unselect_all_icons():
	for iconLoop:Control in icons.get_children():
		iconLoop.unselect()

func _on_magic_stick_press() -> void:
	select_icon(MAGIC_STICK)
	player_select_magic_stick.emit()
	pass # Replace with function body.


func _on_magic_freeze_press() -> void:
	select_icon(MAGIC_FREEZE)
	player_select_magic_freeze.emit()
	pass # Replace with function body.


func _on_magic_fire_press() -> void:
	select_icon(MAGIC_FIRE)
	player_select_magic_fire.emit()
	pass # Replace with function body.
