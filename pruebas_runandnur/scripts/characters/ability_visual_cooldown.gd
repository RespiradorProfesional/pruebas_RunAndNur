extends Node2D

@export var ability_cooldown_var: int
@onready var ability_cooldown_timer=$ability_cooldown

var ability_up=true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ability_cooldown_timer.wait_time=ability_cooldown_var


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_update_second_timeout() -> void:
	if ability_up:
		pass
	pass # Replace with function body.

func _on_ability_cooldown_timeout() -> void:
	pass # Replace with function body.

func _on_character_body_2d_ability_used() -> void:
	pass # Replace with function body.
