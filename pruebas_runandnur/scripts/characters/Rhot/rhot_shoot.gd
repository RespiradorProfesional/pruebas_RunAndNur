extends Area2D

# Velocidad del proyectil
var velocity: Vector2 = Vector2.ZERO
var body_arm

func _process(delta):
	# Actualiza la posición del proyectil según su velocidad
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	velocity.y += get_gravity() * delta


func _on_body_entered(body: Node2D) -> void:
	body_arm.global_position=global_position
