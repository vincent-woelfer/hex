class_name HitBox extends Area3D


# TODO add logic which hitboxes can affect? Either layers or custom

###################################################################
# Variables
###################################################################
const TICK_SECS: float = 0.5

@export var active: bool = true

var inside_areas: Array[Area3D] = []
var inside_timestamps: Array[float] = []

###################################################################
# Signals
###################################################################
# Other HitBox
signal hit_box_entered(hit_box: HitBox)
signal hit_box_tick(hit_box: HitBox)

# HurtBox
signal hurt_box_entered(hurt_box: HurtBox)
signal hurt_box_tick(hurt_box: HurtBox)


###################################################################
# Methods
###################################################################

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _physics_process(delta: float) -> void:
	if not active:
		return

	var now: float = Util.now()

	for idx in range(inside_areas.size()):
		if now - inside_timestamps[idx] >= TICK_SECS:
			# Increment timer for next tick
			inside_timestamps[idx] += TICK_SECS

			var area: Area3D = inside_areas[idx]
			if area is HitBox:
				var hit_box: HitBox = area
				hit_box_tick.emit(hit_box)
			elif area is HurtBox:
				var hurt_box: HurtBox = area
				hurt_box_tick.emit(hurt_box)

			
# This is only called once (entered)
func _on_area_entered(area: Area3D) -> void:
	# Track entered areas
	if not inside_areas.has(area):
		inside_areas.append(area)
		inside_timestamps.append(Util.now())

	if area is HitBox:
		var hit_box: HitBox = area
		if active:
			hit_box_entered.emit(hit_box)
		return
	
	if area is HurtBox:
		var hurt_box: HurtBox = area
		if active:
			hurt_box_entered.emit(hurt_box)
		return


func _on_area_exited(area: Area3D) -> void:
	var idx: int = inside_areas.find(area)
	if idx != -1:
		inside_areas.remove_at(idx)
		inside_timestamps.remove_at(idx)

