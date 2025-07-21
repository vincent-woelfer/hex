@tool
extends Node3D
class_name VFXFlameThrower

static var scene: PackedScene = preload("res://scenes/effects/FlameThrower.tscn")

# https://www.youtube.com/shorts/Q1JE_4JV20o

@export_tool_button("Restart Particles")
var button := start

# TODO refactor
func _ready() -> void:
	if Engine.is_editor_hint():
		return

	var hitbox: HitBox = get_node("HitBox") as HitBox
	hitbox.hurt_box_entered.connect(_on_hurt_box_entered)


func _on_hurt_box_entered(hurt_box: HurtBox) -> void:
	var effect: ActionEffect = ActionEffect.new(ActionEffect.EffectType.DAMAGE, 20)
	hurt_box.apply_all_effects([effect])

static func spawn_at_parent(parent: Node3D) -> VFXFlameThrower:
	var instance := scene.instantiate() as VFXFlameThrower
	Util.spawn(instance, Vector3(0, 1.2, 0), parent)
	instance.start()
	return instance
	

func start() -> void:
	for child in get_children():
		if child is GPUParticles3D:
			pass
			# var particles: GPUParticles3D = child as GPUParticles3D
			# particles.one_shot = true
			# particles.emitting = true
