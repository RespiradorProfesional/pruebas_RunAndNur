extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var in_impulse = false

func _physics_process(delta: float) -> void:
	# Añadir gravedad.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Manejar salto.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Obtener la dirección de entrada para el movimiento.
	var direction := Input.get_axis("ui_left", "ui_right")

	if not in_impulse:
		# Movimiento normal cuando no está bajo impulso.
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		# Durante el impulso, permitir al jugador cambiar de dirección.
		if direction != 0:
			if (velocity.x > 0 and direction < 0) or (velocity.x < 0 and direction > 0):
				# Si la dirección del input es opuesta a la dirección del impulso, reducir velocidad.
				velocity.x = lerp(velocity.x, direction * SPEED, 0.1)
			# Si la dirección coincide con la dirección del impulso, mantener la velocidad.
			elif (velocity.x > 0 and direction > 0) or (velocity.x < 0 and direction < 0):
				# No hacemos nada para mantener la velocidad del impulso.
				pass
	move_and_slide()

	# Si toca el suelo, detener el estado de impulso.
	if is_on_floor() and in_impulse:
		in_impulse = false

# Función para aplicar el impulso.
func apply_central_impulse(impulse: Vector2):
	in_impulse = true
	velocity += impulse  # Sumar el impulso a la velocidad actual.
