extends Area2D

enum PlayerState { NEUTRAL, ATTACK_PREP, ATTACKING, DEFENDING }

export (String) var state

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
