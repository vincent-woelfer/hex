@tool
class_name HealthComponent extends Node3D

var ui: BasicEnemyUI

###################################################################
# Variables
###################################################################

const DEFAULT_MAX = 100

## The current amount of health, clamped to [0, health_max].
@export var health: int = DEFAULT_MAX:
	set(curr):
		health = clampi(curr, 0, health_max)

## The maximum amount of health.
## Will not allow values < 1.
## Will reduce current if greater than updated health_max.
@export var health_max: int = DEFAULT_MAX:
	set(new_max):
		var old_max := health_max
		health_max = maxi(new_max, 1)
		# after health_max is set or current will clamp wrong
		if Engine.is_editor_hint() and health == old_max:
			# keep full health in editor if it was before
			health = health_max
		else:
			# reduce current in game so it is not greater than health_max
			health = mini(health, health_max)


@export_group("Conditions")
@export var damageable: bool = true
@export var healable: bool = true
@export var killable: bool = true

###################################################################
# Signals
###################################################################
signal damaged()
signal died()
signal healed()

###################################################################
# Methods
###################################################################

func _ready() -> void:
	var parent: Node3D = get_parent()
	ui = UIManager.attach_ui_scene(parent, ResLoader.BASIC_ENEMY_UI_SCENE)
	ui.set_max_health(health_max)
	ui.set_health(health)


func is_dead() -> bool:
	return health == 0 and killable

func is_alive() -> bool:
	return not is_dead()

func is_full() -> bool:
	return health == health_max

func percent_health() -> float:
	return clampf(float(health) / float(health_max), 0.0, 1.0)


func apply_effect(effect: ActionEffect) -> void:
	if effect.type == ActionEffect.EffectType.STATUS_EFFECT:
		push_error("Status effects not implemented yet: " + str(effect))
		return

	if effect.type == ActionEffect.EffectType.HEAL:
		_heal(effect.health_change)
	elif effect.type == ActionEffect.EffectType.DAMAGE:
		_damage(effect.health_change)


###################################################################
# Internal Methods 
###################################################################
func _heal(amount: int) -> void:
	if not healable or is_dead():
		return
	health += amount
	health = mini(health, health_max)
	healed.emit()

	ui.set_health(health)

func _damage(amount: int) -> void:
	if not damageable or is_dead():
		return
	health -= amount
	health = maxi(health, 0)
	damaged.emit()
	if is_dead():
		died.emit()

	ui.set_health(health)
