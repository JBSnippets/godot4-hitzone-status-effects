extends Node

## Staus status_effect resource path list
var status_effect_resources: Dictionary = {
	"Damage": "res://addons/jbs_hitzone_node/status_effects/jbs_damage.gd",
	"Heal": "res://addons/jbs_hitzone_node/status_effects/jbs_heal.gd",
	"Knockback": "res://addons/jbs_hitzone_node/status_effects/jbs_knockback.gd"
}

func apply_status_effect(hit_zone: HitZone, hitter, body, status_effects: Array[StatusEffect]) -> void:
	if status_effects.is_empty(): return
	
	if hit_zone.emit_before_apply_status:
		hit_zone.emit_signal("before_apply_status")
		
	for status_effect: StatusEffect in status_effects:
		if !status_effect.has_method("_activate"): continue
		
		# apply random chance if exists
		if status_effect.has_meta("chance_exists"):
			if !(randf() <= status_effect.chance / 100.0): continue
		
		var new_status_effect = load(status_effect.script.resource_path).new() as StatusEffect
		body.add_child(new_status_effect)
		
		# ensure we set the properties before activating
		var properties = status_effect.get_property_list()
		# filter properties only having @export variables
		for property in (properties.filter(func(p): return p.get("usage") & PROPERTY_USAGE_SCRIPT_VARIABLE)):
			new_status_effect.set(property.get("name"), status_effect.get(property.get("name")))
		
		# call the _setup method of the new status_effect if it exists
		if new_status_effect.has_method("_setup"): new_status_effect._setup()
			
		# activate the new status_effect passing the hitter
		new_status_effect._activate(hitter)
	
	if hit_zone.emit_status_applied:
		hit_zone.emit_signal("status_applied")

func create_status_effects(hit_zone: HitZone, status_effect_list: Dictionary) -> void:
	if !hit_zone:
		printerr("Null or missing HitZone")
		return
	
	if !status_effect_list:
		printerr("Null or missing status_effect_list")
		return

	for key in status_effect_list.keys():
		var status_effect_name: String = key
		var resource_path = status_effect_resources.get(key)
		if !resource_path:
			printerr("Can't find '" + key + "' in status_effect resource path list!")
			continue
		# create the new status_effect based on the script
		var status_effect = load(resource_path)
		var new_status_effect = status_effect.new() as StatusEffect
		
		# set the properties e.g. amount
		var properties = status_effect_list.get(key) as Dictionary
		for property in properties.keys():
			var property_value = properties.get(property)
			if property == "status_effect_name":
				status_effect_name = property_value
			new_status_effect.set(property, property_value)
			
		new_status_effect.name = status_effect_name
		hit_zone.call_deferred("add_child", new_status_effect)
	
	hit_zone.call_deferred("_get_child_status_effects")
