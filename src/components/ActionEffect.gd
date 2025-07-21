class_name ActionEffect extends Object

enum EffectType {
    DAMAGE,
    HEAL,
    STATUS_EFFECT
}

var type: EffectType
var health_change: int


func _init(type_: EffectType, health_change_: int) -> void:
    type = type_
    health_change = health_change_


func get_health_change_with_sign() -> int:
    var sgn: int
    match type:
        EffectType.DAMAGE:
            sgn = -1
        EffectType.HEAL:
            sgn = 1
        EffectType.STATUS_EFFECT:
            sgn = 0

    return health_change * sgn

# TODO var source: Node3D
