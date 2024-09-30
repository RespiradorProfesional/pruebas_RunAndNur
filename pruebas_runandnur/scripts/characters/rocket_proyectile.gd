extends Area2D


# Velocidad del proyectil
var velocity: Vector2 = Vector2.ZERO

func _process(delta):
	# Actualiza la posición del proyectil según su velocidad
	position += velocity * delta
