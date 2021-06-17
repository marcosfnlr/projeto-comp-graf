extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func bullet_hit(damage, bullet_global_trans):
	print($MeshInstance.get_active_material(0).albedo_color.b)
	$MeshInstance.get_active_material(0).albedo_color.b8 += 20
#	var direction_vect = bullet_global_trans.basis.z.normalized()*5;
#	apply_impulse((bullet_global_trans.origin - global_transform.origin).normalized(), direction_vect * damage)
