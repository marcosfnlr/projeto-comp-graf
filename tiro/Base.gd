extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	process_input(delta)
#	process_movement(delta)

func process_input(delta):
	
	if Input.is_action_just_pressed("fire"):
			$Player/Rotate/Pistol_Point.fire_weapon()
	# ----------------------------------
