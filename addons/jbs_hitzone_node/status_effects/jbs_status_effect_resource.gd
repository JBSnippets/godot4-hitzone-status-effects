@icon("jbs_status_effects.png")
class_name StatusEffectResource
extends Resource

## A dictionary list of statuses/effects.
##
## The accepted format is as follows:
## { "Status Effect Name" (string): 
##   { "Property Name" (string): Property Value (variant) } 
## }
@export var status_effect_list: Dictionary
