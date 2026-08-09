extends AbstractEnemy
class_name PlatformMushroom

const STATE_WALKING='walking';
const STATE_DAMAGED='damaged'
const STATE_FREEZED='freezed'
const STATE_DIING='diing'

const SPEED = 50.0
var speed := SPEED
var acceleration := 1.2

var life:=10

var direction := -1.0

func get_current_state() -> AbstractPlatfomEnemyState:
	return _get_current_state()

func _physics_process(delta: float) -> void:
	
	if life<=0:
		velocity.x=0
		move_and_slide()

		return
		
	if is_on_wall():
		direction *= -1

	if get_current_state().has_gravity and not is_on_floor():
		velocity += get_gravity() * delta

	if get_current_state().can_move_left_and_right:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration)
	else:
		velocity.x=0
	
	move_and_slide()

func damaged(damage:int):
	switch_to_state(STATE_DAMAGED)
	life-=damage
	if life<=0:
		switch_to_state(STATE_DIING)
	

func remove():
	queue_free()
	
	
func freezed():
	switch_to_state(STATE_FREEZED)

func final_die():
	life-=1
	if life<=0:
		queue_free()


func _on_hit_area_body_entered(body: Node2D) -> void:
	if body is PlatformPlayer:
		GlobalEvents.player_is_damaged.emit()
	pass # Replace with function body.
