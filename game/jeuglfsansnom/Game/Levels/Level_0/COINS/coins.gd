extends Area2D

var Coins = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_Coins_body_entered(body: Node2D) -> void:
	if body is PlatformPlayer:
		GlobalEvents.total_ce_coins = GlobalEvents.total_ce_coins + Coins
		print(GlobalEvents.total_ce_coins)
		#regarde si "le joueur entre en collision avec la coins alors " ajoute 1 coins a sont total
		queue_free()
	pass # Replace with function body.
