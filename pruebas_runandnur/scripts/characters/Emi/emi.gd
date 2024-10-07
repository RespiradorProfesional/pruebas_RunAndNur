extends Player

@onready var ability_cooldown=$ability_cooldown
@onready var ability_duration=$ability_duration

var ability_active=false
signal ability_used
var actual_colision_mask


func ability_pressed():
	actual_colision_mask=collision_mask
	collision_mask = 1
	ability_cooldown.start()
	ability_duration.start()
	ability_active=true

func _on_ability_duration_timeout() -> void:
	collision_mask=actual_colision_mask
	ability_active=false

func _on_ability_cooldown_timeout() -> void:
	ability_available=true

func _physics_process(delta: float) -> void:
	if not ability_active:
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Manejar salto.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	
		if Input.is_action_just_pressed("Ability") and ability_available:
			ability_pressed()
			ability_available=false
		
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
	else :
		var direction= Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized()

		if direction : 
			velocity=direction*SPEED
		else :
			velocity=Vector2.ZERO
	move_and_slide()

	# Si toca el suelo, detener el estado de impulso.
	if is_on_floor() and in_impulse:
		in_impulse = false
