extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEvents.gameover.connect(_on_game_over) 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Coins : " + str(GlobalEvents.total_ce_coins )
	pass

func _on_game_over(): 
		GlobalEvents.total_ce_coins = 0
