@tool
@icon("jbs_status_effect.png")
## An effect that pushes back the target from the node object.
##
## Add this custom node as a child of the HitZone node to include as an item of the HitZone's [param status_effects] array and it will be instantiated to the target adding knockback effect.[br][br]
##
## [color=orange]NOTE:[/color] The default knockback effect setup is for 2D TopDown character. Enable the [member platformer] to setup effect for Platformer character.[br][br]
##
## [color=orange]NOTE:[/color] To apply resistance, please ensure that JBS Status Effect Resistance node is available and with the node named as "StatusEffectResistance" to find and apply knockback resistance.
class_name Knockback
extends StatusEffect

## The duration of knockback.
@export var duration: float = 0.05
## The force applied when knocking back.
@export var force: float = 300
## Enable this to simulate a knockback effect for a platformer character.
@export var platformer: bool = false

@export_category("Random")
## Used by the HitZone to randomly apply this effect. 0 chance means don't apply and 100 chance means always apply.[br][br]
##
## [color=orange]NOTE:[/color] When adding the [param chance] variable to your status effect, you should also add the metadata [param "chance_exists"] to have the HitZone recognize the existence of the variable.
@export_range(0, 100) var chance: float = 100

var _is_processing: bool = false
var _knockback_timer: Timer
var _knockback_vector: Vector2

## Returns the object's class name, as a [String].
func get_class_name() -> String: return "Knockback"

func _ready() -> void:
	set_meta("chance_exists", true)
	
func _setup() -> void:
	_create_knockback_timer()

func _create_knockback_timer() -> void:
	_knockback_timer = Timer.new()
	add_child(_knockback_timer)
	_knockback_timer.one_shot = true
	_knockback_timer.timeout.connect(_on_knockback_timer_timeout)
	
func _on_knockback_timer_timeout() -> void:
	_is_processing = false
	queue_free()
	
func _physics_process(_delta) -> void:
	if _is_processing:
		if !_parent: return
		_parent.velocity = _knockback_vector
		_parent.move_and_slide()

func _activate(_hitter) -> void:
	_parent = get_parent()
	if !_parent: queue_free()
	
	if !_parent.is_class("CharacterBody2D"): queue_free()

	# get JBS Status Effect Resistance is available
	_resistance = 0
	_get_resistance()

	var time_to_knockback = duration - _resistance
	if time_to_knockback <= 0:
		queue_free()
		return
		
	var direction_to_node
	var inverse = -1
	if platformer:
		direction_to_node = Vector2(_hitter.global_position.x, _parent.global_position.y - _hitter.global_position.y)
		if _parent.global_position.x > _hitter.global_position.x: inverse = 1
	else:
		direction_to_node = _parent.global_position.direction_to(_hitter.global_position)
	
	var knockback_direction = direction_to_node * inverse #Invert direction
	_knockback_vector = knockback_direction.normalized() * force

	_knockback_timer.wait_time = time_to_knockback
	_knockback_timer.start()
	_is_processing = true
