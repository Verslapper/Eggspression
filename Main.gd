extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var stopStopHesAlreadyDead = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.

	if get_node("Player").state == "ATTACKING" && get_node("Enemy").state != "DEFENDING":
		you_win()
	elif get_node("Enemy").state == "ATTACKING" && get_node("Player").state != "DEFENDING":
		you_lose()
	
	if !stopStopHesAlreadyDead:
		if Input.is_action_pressed("ui_left"):
			get_node("Player").state = "DEFENDING"
			get_node("HUD/PlayerStateLabel").text = "Defend!"
		if Input.is_action_pressed("ui_right"):
			get_node("Player").state = "ATTACKING" # make this ATTACK_PREP when you can time that state transition to "ATTACKING"
			get_node("HUD/PlayerStateLabel").text = "Attack!"
			
		if (randi() % 100 == 0):
			get_node("Enemy").state = "ATTACKING"
			get_node("HUD/EnemyStateLabel").text = "Attack!"
		elif (randi() % 70 == 0):
			get_node("Enemy").state = "DEFENDING"
			get_node("HUD/EnemyStateLabel").text = "Defend!"
		else:
			get_node("Enemy").state = "NEUTRAL"
			get_node("HUD/EnemyStateLabel").text = "Ready!"
		

	# OK, so I gotta:
		# detect player input
		# honour player selection
		# broadcast state change (visually)
		# make enemy detect player state occasionally (timing windows)
		# make enemy react to player state
		# prevent turtling with a defend cooldown/pool
		
	pass
	
func you_win():
	stopStopHesAlreadyDead = true
	get_node("HUD/PlayerStateLabel").text = "GG EZ"
	# Display success, increment win tally, prompt for reset button
	pass
	
func you_lose():
	stopStopHesAlreadyDead = true
	get_node("HUD/PlayerStateLabel").text = "FFS RIP"
	# Display failure, increment loss tally, prompt for reset button
	pass

func reset():
	get_node("Player").state = "NEUTRAL"
	get_node("Enemy").state = "NEUTRAL"