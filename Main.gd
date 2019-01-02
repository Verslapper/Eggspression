extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.

	if get_node("Player").state == ATTACKING && get_node("Enemy").state != DEFENDING:
		you_win()
	elif get_node("Enemy").state == ATTACKING && get_node("Player").state != DEFENDING:
		you_lose()
		
	if Input.is_action_pressed("ui_left"):
		get_node("Player").state = DEFENDING
	if Input.is_action_pressed("ui_right"):
		get_node("Player").state = ATTACK_PREP

	# OK, so I gotta:
		# detect player input
		# honour player selection
		# broadcast state change (visually)
		# make enemy detect player state occasionally (timing windows)
		# make enemy react to player state
		# prevent turtling with a defend cooldown/pool
		
	pass
	
func you_win():
	# Display success, increment win tally, prompt for reset button
	pass
	
func you_lose():
	# Display failure, increment loss tally, prompt for reset button
	pass

func reset():
	get_node("Player").state = NEUTRAL
	get_node("Enemy").state = NEUTRAL