@tool
@icon("jbs_status_effect_resistance.png")
## A custom node used to apply status/effect resistances to a target.
##
## Add this custom node as a child of the parent node body to add and apply status/effect resistances.
class_name StatusEffectResistance
extends Node

## A list of status/effect resistance.[br][br]
##
## The accepted format is as follows:[br][br]
## { [code]"Status Effect Name"[/code]: (variant) [code]Value[/code] }
@export var resistances: Dictionary = {
	"Damage": 0,
	"Heal": 0,
	"Knockback": 0.0
}

## Returns the object's class name, as a [String].
func get_class_name() -> String: return "StatusEffectResistance"
