extends Area2D

# Fuerza máxima de la explosión en el centro
@export var max_force = 1000.0
# Velocidad del proyectil
var velocity: Vector2 = Vector2.ZERO
@export var explosion_radius = 300.0
@onready var explosion_area=$Explosion_area

func _process(delta):
	# Actualiza la posición del proyectil según su velocidad
	position += velocity * delta

# Llamar a esta función cuando ocurra la explosión
func explode():
	# Obtiene todos los cuerpos dentro del área
	var overlapping_bodies = explosion_area.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.has_method("apply_central_impulse"):
			# Calcula la distancia del cuerpo al centro de la explosión
			var distance = global_position.distance_to(body.global_position)
			
			# Asegúrate de que la distancia no sea mayor que el radio de la explosión
			if distance < explosion_radius:
				# Calcula la dirección de la fuerza desde el centro de la explosión
				var direction = (body.global_position - global_position).normalized()
				
				# Calcula la fuerza proporcional inversa a la distancia (más cerca = más fuerza)
				var force = max_force * (1.0 - (distance / explosion_radius))
				
				# Aplica el impulso al cuerpo
				body.apply_central_impulse(direction * force)


func _on_body_entered(body: Node2D) -> void:
	explode()
