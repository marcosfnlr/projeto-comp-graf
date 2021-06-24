extends Spatial

const DAMAGE = 15

const IDLE_ANIM_NAME = "Pistol_idle"
const FIRE_ANIM_NAME = "Pistol_fire"

var is_weapon_enabled = false

var bullet_scene = preload("Bullet.tscn")

var player_node = null

func _ready():
	pass

func fire_weapon():
	var clone = bullet_scene.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)

	clone.global_transform = self.global_transform
	clone.scale = Vector3(4, 4, 4)
	clone.BULLET_DAMAGE = DAMAGE
