extends Node

signal death()
signal revive()

@export var progress: ProgressBar

var amount: float = 100
var max_amount: float = 100

func _ready() -> void:
	if progress: progress.value = max_amount
	death.connect(_on_death)
	revive.connect(_on_revive)
	
func _on_death() -> void:
	pass
	
func _on_revive() -> void:
	pass

func update_amount(_amount: float) -> void:
	var old_amount = amount
	
	if _amount > max_amount or (amount + _amount) > max_amount:
		amount = max_amount
	else:
		amount += _amount
			
	if amount < 0: amount = 0
	
	if progress: progress.value = amount
			
	if _amount > 0:
		if old_amount == 0: emit_signal("revive")
		return
		
	if amount == 0: emit_signal("death")
