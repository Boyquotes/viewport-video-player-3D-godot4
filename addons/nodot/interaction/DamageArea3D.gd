## An area that, when entered, deals damage (or heals) the colliding body
class_name DamageArea3D extends Area3D

## Damage to deal (negative numbers for healing)
@export var damage: float = 1.0
## The interval to deal the damage
@export var damage_interval: float = 1.0

## Triggered when a body is damaged (or healed) by the area
signal damage_given


func _init():
	var timer: Timer = Timer.new()
	timer.autostart = true
	timer.wait_time = damage_interval
	timer.connect("timeout", action)
	add_child(timer)


## Deals damage to all overlapping bodies
func action():
	var colliders = get_overlapping_bodies()
	if colliders.size() > 0:
		for collider in colliders:
			for child in collider.get_children():
				if child is Health:
					child.add_health(-damage)
					emit_signal("damage_given")
