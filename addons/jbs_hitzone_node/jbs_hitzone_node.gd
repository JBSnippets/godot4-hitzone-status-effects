@tool
extends EditorPlugin

# scripts
const DAMAGE_SCRIPT = "res://addons/jbs_hitzone_node/status_effects/jbs_damage.gd"
const HEAL_SCRIPT = "res://addons/jbs_hitzone_node/status_effects/jbs_heal.gd"
const HITZONE_SCRIPT = "res://addons/jbs_hitzone_node/jbs_hitzone.gd"
const KNOCKBACK_SCRIPT = "res://addons/jbs_hitzone_node/status_effects/jbs_knockback.gd"
const STATUS_EFFECT_SCRIPT = "res://addons/jbs_hitzone_node/status_effects/jbs_status_effect.gd"
const STATUS_EFFECT_MANAGER_SCRIPT = "res://addons/jbs_hitzone_node/status_effects/jbs_status_effect_manager.gd"
const STATUS_EFFECT_RESISTANCE_SCRIPT = "res://addons/jbs_hitzone_node/status_effects/jbs_status_effect_resistance.gd"
const STATUS_EFFECT_RESOURCE_SCRIPT = "res://addons/jbs_hitzone_node/status_effects/jbs_status_effect_resource.gd"

# icons
const DAMAGE_ICON = "res://addons/jbs_hitzone_node/status_effects/jbs_status_effect.png"
const HEAL_ICON = DAMAGE_ICON
const HITZONE_ICON = "res://addons/jbs_hitzone_node/jbs_hitzone_node.png"
const KNOCKBACK_ICON = DAMAGE_ICON
const STATUS_EFFECT_RESISTANCE_ICON = "res://addons/jbs_hitzone_node/status_effects/jbs_status_effect_resistance.png"

var script_dictionary: Dictionary = {
	"Damage": DAMAGE_SCRIPT,
	"Heal": HEAL_SCRIPT,
	"HitZone": HITZONE_SCRIPT,
	"Knockback": KNOCKBACK_SCRIPT,
	"StatusEffect": STATUS_EFFECT_SCRIPT,
	"StatusEffectManager": STATUS_EFFECT_MANAGER_SCRIPT,
	"StatusEffectResistance": STATUS_EFFECT_RESISTANCE_SCRIPT,
	"StatusEffectResource": STATUS_EFFECT_RESOURCE_SCRIPT
}

func _enter_tree():
	add_autoload_singleton("StatusEffectManager", STATUS_EFFECT_MANAGER_SCRIPT)
	add_custom_type("Knockback", "Node", preload(KNOCKBACK_SCRIPT), preload(KNOCKBACK_ICON))
	add_custom_type("Damage", "Node", preload(DAMAGE_SCRIPT), preload(DAMAGE_ICON))
	add_custom_type("Heal", "Node", preload(HEAL_SCRIPT), preload(HEAL_ICON))
	add_custom_type("StatusEffectResistance", "Node", preload(STATUS_EFFECT_RESISTANCE_SCRIPT), preload(STATUS_EFFECT_RESISTANCE_ICON))
	add_custom_type("HitZone", "Node", preload(HITZONE_SCRIPT), preload(HITZONE_ICON))
	
	_reload_scripts()

func _exit_tree():
	remove_custom_type("HitZone")
	remove_custom_type("StatusEffectResistance")
	remove_custom_type("Heal")
	remove_custom_type("Damage")
	remove_custom_type("Knockback")
	remove_autoload_singleton("StatusEffectManager")

# Workaround to save script and force reload/refresh of script plugin documentations
func _reload_scripts():
	for key in script_dictionary.keys():
		var script_path = script_dictionary.get(key)
		var script = ResourceLoader.load(script_path)
		if script:
			ResourceSaver.save(script, script_path)
