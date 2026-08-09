extends AbstractActor
class_name PlatformPlayer

const SPEED = 2800.0
const SPEED_MAX =  4050.0
const JUMP_VELOCITY = -270.0
const SUPER_JUMP_VELOCITY = -450.0

var speed := SPEED
var acceleration := 1.2

const SUPER_ACCELERATION := 2.0

const STATE_IDLE_WITHOUT_STICK="idle-without-stick"
const STATE_WALKING_WITHOUT_STICK = "walking-without-stick"

const STATE_IDLE = "idle"
const STATE_WALKING = "walking"
const STATE_USE_MAGIC_STICK = "use-magic-stick"

const STATE_DAMAGED="damaged"

const ANIM_USER_MAGIC_STICK="use-magic-stick"
const ANIM_USER_MAGIC_FREEZE="use-magic-freeze"
const ANIM_USER_MAGIC_FIRE="use-magic-fire"

var has_magic_stick = false

var current_jump_velocity := JUMP_VELOCITY

var _direction:float=0.0

@onready var hitBoxArea:CollisionShape2D=$Sprite2D/hit/CollisionShape2D

@onready var fireMarker2D:Marker2D=$Sprite2D/hit/fireMarker2D

const FIREBALL_SCENE = preload("res://Game/Actors/Players/Platform/fire-ball.tscn")

var anim_magic_stick:String='use-magic-stick'

func select_magic_stick():
	anim_magic_stick=ANIM_USER_MAGIC_STICK

func select_magic_freeze():
	anim_magic_stick=ANIM_USER_MAGIC_FREEZE

func select_magic_fire():
	anim_magic_stick=ANIM_USER_MAGIC_FIRE

func _ready() -> void:
	hitBoxArea.disabled=true
	
	GlobalEvents.got_magic_stick.connect(bring_magic_stick)	

func took_damage():
	switch_to_state(STATE_DAMAGED)

func bring_magic_stick():
	has_magic_stick = true

func get_current_state() -> AbstractPlatfomPlayerState:
	return _get_current_state()

func _physics_process(delta: float) -> void:

	if get_current_state().has_gravity and not is_on_floor():
		velocity += get_gravity() * delta

	if get_current_state().can_jump and PlayerInputSingleton.does_player_press_jump() and is_on_floor():
		velocity.y = current_jump_velocity

	if has_magic_stick and PlayerInputSingleton.does_player_press_use_magic_stick():
		print('swithch magick stick')
		switch_to_state_and_override_animation(STATE_USE_MAGIC_STICK,anim_magic_stick)
 
	if get_current_state().can_move_left_and_right:
		
		if get_current_state().name == STATE_DAMAGED:
			return
		
		_direction = PlayerInputSingleton.get_player_left_or_right_direction()
		if _direction:
			if get_current_state().name == STATE_IDLE or get_current_state().name == STATE_IDLE_WITHOUT_STICK:
				if has_magic_stick:
					switch_to_state(STATE_WALKING)
				else:
					switch_to_state(STATE_WALKING_WITHOUT_STICK)

			if get_current_state().has_gravity and not is_on_floor():
				velocity.x = move_toward(velocity.x, _direction * speed, acceleration)
			else:
				velocity.x = move_toward(velocity.x, _direction * speed*delta, acceleration)
 
			sprite.flip_h = (_direction == -1)

			if _direction == -1:
				hitBoxArea.position.x =-10
				fireMarker2D.position.x = -10
				
			else:
				hitBoxArea.position.x =10
				fireMarker2D.position.x = 10

			 

		else:
			
			velocity.x = move_toward(velocity.x, 0, SPEED)

			if velocity.x == 0:
				if has_magic_stick:
					switch_to_state(STATE_IDLE)
				else:	
					switch_to_state(STATE_IDLE_WITHOUT_STICK)

		
	move_and_slide()
	
func improve_jump_velocity():
	current_jump_velocity = SUPER_JUMP_VELOCITY
	acceleration = SUPER_ACCELERATION
	speed = SPEED_MAX
	$Sprite2D.modulate = Color(1, 2, 1)

func shoot_fireball():
	print('shoot')
	var fireball = FIREBALL_SCENE.instantiate()
	fireball.global_position = fireMarker2D.global_position
	get_tree().root.add_child(fireball)
	
	var fireball_direction=1.0
	if hitBoxArea.position.x < 0:
		fireball_direction=-1.0
		
	fireball.set_direction(fireball_direction)
	
	

func _on_hit_body_entered(body: Node2D) -> void:
 	
	if anim_magic_stick==ANIM_USER_MAGIC_STICK && body.has_method('damaged'):
		body.damaged()
	elif anim_magic_stick==ANIM_USER_MAGIC_FREEZE && body.has_method('freezed'):
		body.freezed()
