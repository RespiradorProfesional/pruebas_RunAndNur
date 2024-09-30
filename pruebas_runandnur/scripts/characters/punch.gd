extends Node2D

var projectile_scene=preload("res://scripts/characters/rocket_proyectile.gd")
# Velocidad del proyectil
@export var projectile_speed: float = 500.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Obtiene la posición del mouse en el espacio del mundo
	var mouse_position = get_global_mouse_position()
	
	# Calcula la dirección desde el jugador hasta el mouse
	var direction = mouse_position - global_position
	
	# Calcula el ángulo en radianes de la dirección y lo convierte a grados
	var angle = direction.angle()
	
	# Establece la rotación del nodo hacia el ángulo calculado
	rotation = angle
	
	# Verifica si se presiona el botón de disparo (ej: clic izquierdo)
	if Input.is_action_just_pressed("shoot"):
		shoot()

# Función para disparar un proyectil
func shoot():
	# Instancia el proyectil
	var projectile = projectile_scene.instantiate()
	
	# Establece la posición del proyectil en el centro del sprite que dispara
	projectile.global_position = global_position
	
	# Calcula la dirección basado en la rotación del nodo
	var direction = Vector2.RIGHT.rotated(rotation)
	
	# Asigna la velocidad al proyectil (asumiendo que tiene una variable velocity)
	projectile.velocity = direction * projectile_speed
	
	# Añade el proyectil al árbol de la escena
	get_tree().root.add_child(projectile)
