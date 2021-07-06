extends KinematicBody


# stats
var health : int = 1
var moveSpeed : float = 1.0
 
# attacking
var damage : int = 1
var attackRate : float = 1.0
var attackDist : float = 2.0
var currentScore : int = 0
var scoreToGive : int = 1
 
# components
onready var player : Node = get_node("/root/MainScene/Player")
onready var timer : Timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	# setup the timer
	timer.set_wait_time(attackRate)
	timer.start()

# called every 'attackRate' seconds
func _on_Timer_timeout ():
 
	# if we're at the right distance, attack the player
	if translation.distance_to(player.translation) <= attackDist:
		attack()
	
func _physics_process (Delta):
 
	# calculate direction to the player
	var dir = translation.normalized()
	dir.y = 0
	dir.x = 0
	dir.z = -0.8
	if translation.z < -4.5:
		translation.z = 4
	# move the enemy towards the player
	move_and_slide(dir * moveSpeed, Vector3.LEFT)
	
# called when we get damaged by the player
func take_damage (damage):
 
	health -= damage
 
	# if we've ran out of health - die
	if health <= 0:
		die()
		
# called when our health reaches 0
func die ():
 
	currentScore = player.add_score(scoreToGive)
	var dir = translation.normalized()
	translation.z = 4
	if currentScore % 5 == 0 && currentScore != 0:
		moveSpeed += 1
	
# deals damage to the player
func attack ():
 
	player.take_damage(damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
