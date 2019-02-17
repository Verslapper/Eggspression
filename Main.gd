extends Node

var stopStopHesAlreadyDead = false
var playerWins = 0
var enemyWins = 0

func _ready():
	randomize()
	reset()
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.

	if !stopStopHesAlreadyDead:
		if get_node("Player").state == "ATTACKING" && get_node("Enemy").state != "DEFENDING":
			you_win()
		elif get_node("Enemy").state == "ATTACKING" && get_node("Player").state != "DEFENDING":
			you_lose()
		
	if !get_node("Timer").is_stopped():
		get_node("HUD/TimerLabel").text = "Starting in " + str(int(get_node("Timer").time_left + 1))
	else:
		get_node("HUD/TimerLabel").hide()
	
	if !stopStopHesAlreadyDead && get_node("Timer").is_stopped():
		if Input.is_action_pressed("ui_left"):
			get_node("Player").state = "DEFENDING"
			get_node("HUD/PlayerStateLabel").text = "Defend!"
		elif Input.is_action_pressed("ui_right"):
			# make this ATTACK_PREP when you can time that state transition to "ATTACKING"
			get_node("Player").state = "ATTACKING"
			get_node("HUD/PlayerStateLabel").text = "Attack!"
			
		if (randi() % 100 == 0):
			get_node("Enemy").state = "ATTACKING"
			get_node("HUD/EnemyStateLabel").text = "Attack!"
		elif (randi() % 70 == 0):
			get_node("Enemy").state = "DEFENDING"
			get_node("HUD/EnemyStateLabel").text = "Defend!"
		elif (randi() % 10 == 0):
			get_node("Enemy").state = "NEUTRAL"
			get_node("HUD/EnemyStateLabel").text = "Ready!"

	# OK, so I gotta:
		# detect player input
		# honour player selection
		# broadcast state change (visually)
		# make enemy detect player state occasionally (timing windows)
		# make enemy react to player state
		# prevent turtling with a defend cooldown/pool
	
	if stopStopHesAlreadyDead:
		get_node("HUD/TimerLabel").show()
		if Input.is_action_pressed("ui_accept"):
			reset()
	pass
	
func you_win():
	stopStopHesAlreadyDead = true
	playerWins += 1
	setWinCounter(get_node("HUD/PlayerWinLabel"), playerWins)
	get_node("HUD/PlayerStateLabel").text = "GG EZ"
	get_node("HUD/TimerLabel").text = "Go again? Press enter!"
	pass
	
func you_lose():
	stopStopHesAlreadyDead = true
	enemyWins += 1
	setWinCounter(get_node("HUD/EnemyWinLabel"), enemyWins)
	get_node("HUD/PlayerStateLabel").text = "FFS RIP"
	get_node("HUD/TimerLabel").text = "Go again? Press enter!"
	pass
	
func setWinCounter(labelNode, winCount):
	if (winCount > 0):
		labelNode.text = str(winCount)
		labelNode.show()
	else:
		labelNode.hide()

func reset():
	get_node("Player").state = "NEUTRAL"
	get_node("Enemy").state = "NEUTRAL"
	get_node("HUD/PlayerStateLabel").text = "Ready!"
	get_node("HUD/EnemyStateLabel").text = "Ready!"
	get_node("Timer").start()
	stopStopHesAlreadyDead = false