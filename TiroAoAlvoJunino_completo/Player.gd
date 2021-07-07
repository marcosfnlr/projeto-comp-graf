extends KinematicBody

onready var muzzle = get_node("Camera/GunModel/Muzzle")
onready var bulletScene = preload("res://Bullet.tscn")
onready var ui : Node = get_node("/root/MainScene/CanvasLayer/UI")

var score : int = 0
var timer = 0

# physics
var moveSpeed : float = 5.0
var jumpForce : float = 5.0
var gravity : float = 12.0
 
# cam look
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
var lookSensitivity : float = 0.6
 
# vectors
var vel : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()
 
# player components
onready var camera = get_node("Camera")

# called when an input is detected
func _input (event):
 
	# did the mouse move?
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

func shoot ():
	var bullet = bulletScene.instance()
	get_node("/root/MainScene").add_child(bullet)
 
	bullet.global_transform = muzzle.global_transform
	bullet.scale = Vector3(3,3,3)

# called every frame
func _process (delta):
	if timer > 0:
		timer -= delta
	# rotate camera along X axis
	camera.rotation_degrees -= Vector3(rad2deg(mouseDelta.y), 0, 0) * lookSensitivity * delta
 
	# clamp the vertical camera rotation
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	# rotate player along Y axis
	rotation_degrees -= Vector3(0, rad2deg(mouseDelta.x), 0) * lookSensitivity * delta
	
	# reset the mouse delta vector
	mouseDelta = Vector2()
	
	if Input.is_action_just_pressed("shoot"):
		if timer <= 0:
			shoot()
			timer = 1
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
# called every physics step
func _physics_process (Delta):
	# reset the x and z velocity
	vel.x = 0
	vel.z = 0
	 
	var input = Vector2()
	 
	# movement inputs
	if Input.is_action_pressed("move_forward"):
		input.y -= 1
	if Input.is_action_pressed("move_backward"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
 
# normalize the input so we can't move faster diagonally
	input = input.normalized()
	# get our forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	# set the velocity
	vel.z = (forward * input.y + right * input.x).z * moveSpeed
	vel.x = (forward * input.y + right * input.x).x * moveSpeed
	 
	# apply gravity
	vel.y -= gravity * Delta
	 
	# move the player
	vel = move_and_slide(vel, Vector3.UP)
	# jump if we press the jump button and are standing on the floor
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForce
 
# called when we kill an enemy
func add_score (amount):
	score += amount
	ui.update_score_text(score)
	return score

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ui.update_score_text(score)
