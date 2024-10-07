extends Area2D
class_name rhot_shoot

# Velocidad del proyectil
var velocity: Vector2 = Vector2.ZERO
var arm_body

func _process(delta):
	# Actualiza la posición del proyectil según su velocidad
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	velocity.y += get_gravity() * delta


func _on_body_entered(body: Node2D) -> void:
	arm_body.global_position=global_position
