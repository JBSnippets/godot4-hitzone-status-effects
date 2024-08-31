@tool
@icon("jbs_status_effect.png")
## An effect that deals an amount of damage to health.
##
## Add this custom node as a child of the HitZone node to include as an item of the HitZone's [param status_effects] array and it will be instantiated to the target dealing damage to the Health Node.[br][br]
##
## [color=orange]NOTE:[/color] Please ensure that JBS Health node is available, or an equivalent node with [param update_amount] function, and with the node named as "Health" to apply the damage.[br][br]
##
## [color=orange]NOTE:[/color] To apply resistance, please ensure that JBS Status Effect Resistance node is available and with the node named as "StatusEffectResistance" to find and apply damage resistance.
class_name Damage
extends StatusEffect

## The amount of damage dealt to health.
@export var amount: int = 10

## Returns the object's class name, as a [String].
func get_class_name() -> String: return "Damage"

# NOTE: Important function when creating your own status/effect
func _activate(_hitter) -> void:
	_parent = get_parent()
	if !_parent: queue_free()
	
	# check if JBS Health node (or equivalent) is available
	var health = _parent.find_child("Health")
	if !health or !health.has_method("update_amount"): queue_free()
	
	# get JBS Status Effect Resistance if available
	_resistance = 0
	_get_resistance()

	# since this is damage, ensure we make the positive amount to negative value
	health.update_amount(-abs(amount) + _resistance)
		
	queue_free()
