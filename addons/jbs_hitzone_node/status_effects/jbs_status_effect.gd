@icon("jbs_status_effect.png")
## The base Status Effect class
class_name StatusEffect
extends Node

## The name of this status effect. Used for finding status effect resistances. If this name is empty, the name set in the script is used.
@export var status_effect_name: String

var _parent
var _resistance

## Returns the object's class name, as a [String].
func get_class_name() -> String: return "StatusEffect"

func _get_resistance() -> void:
	if !_parent: return
	var status_effect_resistance = _parent.find_child("StatusEffectResistance")
	if status_effect_resistance and !status_effect_resistance.resistances.is_empty():
		var resistance_name: String = get_class_name()
		if !status_effect_name.is_empty():
			resistance_name = status_effect_name
		if status_effect_resistance.resistances.has(resistance_name):
			_resistance = status_effect_resistance.resistances.get(resistance_name)
