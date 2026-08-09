extends Node2D

@onready var hud:HudPlatform=$PlatformPlayer/Camera2D/HUD

@onready var player:PlatformPlayer=$PlatformPlayer

const DEBUG=false
const MAX_LIFE=4

var _life:int=4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEvents.got_magic_stick.connect(on_player_got_magic_stick)
	
	GlobalEvents.got_magic_freeze_sort.connect(on_player_got_magic_freeze_sort)
	GlobalEvents.got_magic_fire_sort.connect(on_player_got_magic_fire_sort)
	
	GlobalEvents.player_is_damaged.connect(on_player_is_damaged)
	
	GlobalEvents.gameover.connect(on_gameover)

	if DEBUG:
		
		GlobalEvents.got_magic_stick.emit()
		GlobalEvents.got_magic_freeze_sort.emit()
		GlobalEvents.got_magic_fire_sort.emit()

		player.position.x+=200
	
	hud.build_lifes(MAX_LIFE)

	pass # Replace with function body.

func on_gameover():
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Screens/gameover.tscn")

func update_life():
	hud.update_life(_life)

func on_player_is_damaged():
	player.took_damage()
	_life-=1
	update_life()
	
	if _life==0:
		GlobalEvents.gameover.emit()
	pass

func on_player_got_magic_stick():
	hud.enableIcon(HudPlatform.MAGIC_STICK)
	hud._on_magic_stick_press()

func on_player_got_magic_freeze_sort():
	hud.enableIcon(HudPlatform.MAGIC_FREEZE)
	hud._on_magic_freeze_press()

func on_player_got_magic_fire_sort():
	hud.enableIcon(HudPlatform.MAGIC_FIRE)
	hud._on_magic_fire_press()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerInputSingleton.does_player_select_magic_stick():
		hud._on_magic_stick_press()
	elif PlayerInputSingleton.does_player_select_magic_freeze():
		hud._on_magic_freeze_press()
	elif PlayerInputSingleton.does_player_select_magic_fire():
		hud._on_magic_fire_press()


func _on_hud_player_select_magic_fire() -> void:
	player.select_magic_fire()
	pass # Replace with function body.


func _on_hud_player_select_magic_freeze() -> void:
	player.select_magic_freeze()

	pass # Replace with function body.


func _on_hud_player_select_magic_stick() -> void:
	player.select_magic_stick()
	pass # Replace with function body.
