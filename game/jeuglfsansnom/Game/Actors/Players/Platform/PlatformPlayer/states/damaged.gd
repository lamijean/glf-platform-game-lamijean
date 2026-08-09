extends AbstractPlatfomPlayerState

func end(_current_animation: String):
	exit(PlatformPlayer.STATE_IDLE)
	
