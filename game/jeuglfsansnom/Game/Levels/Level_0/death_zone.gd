extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# regarde si le joueur entre dans la zone de mort puis envoie un signal de mort. 
func _on_Death_Zone_2d_body_entered(body: Node2D) -> void:   
	print("en attente de mort")
	GlobalEvents.gameover.emit()
	pass # Replace with function body.
