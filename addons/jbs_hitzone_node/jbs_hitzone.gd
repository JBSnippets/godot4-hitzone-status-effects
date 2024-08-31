@tool
@icon("jbs_hitzone_node.png")
## A custom node used to detect a hit from an attack and creates a series of status and/or effects on the target.
##
## This custom node can be used to detect a hit from an attack by monitoring collisions when a node body enters the selected Area2D. After calling the [method hit_body] either manually or automatically when collision is detected, status and/or effects are created in the target node body.[br][br]
##
## [color=orange]NOTE:[/color] Please ensure that the HitZone node is the child of the parent node designated as the "hitter". This is important when calculating global position.[br][br]
class_name HitZone
extends Node

## This signal is emitted when the HitZone has finished applying status and/or effects.[br][br]
##
## [color=orange]NOTE[/color]: This is emitted only if [member emit_status_applied] is set to true.
signal status_applied()
## This signal is emitted before the HitZone applies status and/or effects.[br][br]
##
## [color=orange]NOTE[/color]: This is emitted only if [member emit_before_apply_status] is set to true.
signal before_apply_status()

## The node group affected by this hit zone.
@export var attack_group: Array = ["Enemy"]

@export_category("Area2D")
## The Area2D used to monitor a hit.
@export var area_2d: Area2D
## Enable this to set the Area2D monitoring on ready state.
@export var monitor_on_ready: bool = false
## Enable this to set auto hit detection when body collides with Area2D. Useful if the body is used as a projectile or spike.
@export var auto_hit: bool = true

@export_category("Status / Effects")
## Enable this to apply status and/or effects using the JBS [code]StatusManager[/code].[br][br]
##
## The JBS [code]StatusManager[/code] singleton must be enabled to use this feature.[br][br]
##
## [color=orange]NOTE[/color]: If disabled, the HitZone will use it's internal [code]apply effect[/code] function to instantiate status and/or effects on the target body.
@export var use_manager: bool = false
## Enable this to emit the [signal status_applied] signal.
@export var emit_status_applied: bool = false
## Enable this to emit the [signal before_apply_status] signal.
@export var emit_before_apply_status: bool = false

var _status_effects: Array[StatusEffect]
var _status_effect_manager

## Returns the object's class name, as a [String].
func get_class_name() -> String: return "HitZone"

func _ready() -> void:
	if Engine.is_editor_hint(): return
	_status_effect_manager = get_tree().root.get_node("/root/StatusEffectManager")
	if !area_2d: return
	_get_child_status_effects()
	randomize()
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.monitoring = monitor_on_ready
	
func _on_body_entered(body) -> void:
	if !auto_hit: return
	hit_body(body)

## A function to check if the node body belongs to the group being attacked and applies the status/effects in the [param status_effects] collection.[br][br]
##
## [color=orange]NOTE[/color]: The [param status_effects] collection is populated by reading the child nodes of the HitZone.
func hit_body(body) -> void:
	if attack_group.is_empty(): return
	for ag in attack_group:
		if body.is_in_group(ag): _apply_status_effect(body)

func _get_child_status_effects() -> void:
	_status_effects.clear()
	for child in get_children():
		if child is StatusEffect:
			_status_effects.append(child)

func _apply_status_effect(body) -> void:
	if use_manager:
		if !_status_effect_manager: 
			printerr("Please enable the JBS StatusManager singleton")
			return
		_status_effect_manager.apply_status_effect(self, get_parent(), body, _status_effects)
	else:
		if _status_effects.is_empty(): return
		
		if emit_before_apply_status:
			emit_signal("before_apply_status")
			
		for effect: StatusEffect in _status_effects:
			if !effect.has_method("_activate"): continue
			
			# apply random chance if exists
			if effect.has_meta("chance_exists"):
				if !(randf() <= effect.chance / 100.0): continue
			
			var new_effect = load(effect.script.resource_path).new() as StatusEffect
			body.add_child(new_effect)
			
			# ensure we set the properties before activating
			var properties = effect.get_property_list()
			# filter properties only having @export variables
			for property in (properties.filter(func(p): return p.get("usage") & PROPERTY_USAGE_SCRIPT_VARIABLE)):
				new_effect.set(property.get("name"), effect.get(property.get("name")))
			
			# call the _setup method of the effect if it exists
			if new_effect.has_method("_setup"): new_effect._setup()
				
			# activate the effect passing the parent of the hit zone as the hitter
			new_effect._activate(get_parent())
			
		if emit_status_applied:
			emit_signal("status_applied")
