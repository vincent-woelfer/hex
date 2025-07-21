class_name HitBox extends Area3D

@export var active: bool = true

# TODO add logic which hitboxes can affect? Either layers or custom

# TODO add logic to apply only once per tick/entity/...?

signal hit_box_entered(hit_box: HitBox)
signal hurt_box_entered(hurt_box: HurtBox)

func _ready() -> void:
	area_entered.connect(_on_area_entered)


# This is only called once (entered)
func _on_area_entered(area: Area3D) -> void:
	if not active:
		return
	
	if area is HitBox:
		var hit_box: HitBox = area
		hit_box_entered.emit(hit_box)
		return
	
	if area is HurtBox:
		var hurt_box: HurtBox = area
		hurt_box_entered.emit(hurt_box)
		return
