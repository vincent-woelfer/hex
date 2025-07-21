extends Control
class_name BasicEnemyUI


@onready var health_bar: TextureProgressBar = $HealthBar

var max_val: float = 100.0

func set_max_health(max_val_: float) -> void:
	max_val = max_val_
	
	health_bar.min_value = 0.0
	health_bar.max_value = max_val

func set_health(current: float) -> void:
	health_bar.value = clampf(current, 0.0, max_val)

