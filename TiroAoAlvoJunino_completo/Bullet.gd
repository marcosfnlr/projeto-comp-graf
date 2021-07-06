extends Area


var speed : float = 10
var damage : int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# called every frame
func _process (delta):
 
	# move the bullet forwards
	translation += -global_transform.basis.z * speed * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# called when we enter the collider of another body
func _on_Bullet_body_entered (body):
	# does this body have a 'take_damage' function?
	# if so, deal damage and destroy the bullet
	if body.has_method("take_damage"):
		body.take_damage(damage)
		destroy()

# destroys the bullet
func destroy ():
 
	queue_free()
