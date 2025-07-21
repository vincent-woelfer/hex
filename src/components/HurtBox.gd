class_name HurtBox extends Area3D

@onready var health_component: HealthComponent = get_parent()

# TODO add logic which hitboxes can affect? Either layers or custom

func apply_all_effects(effects: Array[ActionEffect]) -> void:
    for effect in effects:
        health_component.apply_effect(effect)



