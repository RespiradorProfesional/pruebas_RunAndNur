extends Node2D

@export var projectile_rute : String
# Velocidad del proyectil
@onready var sprite_arm=$Sprite2D
@export var projectile_speed: float = 500.0

var body_arm

func _ready() -> void:
	body_arm=get_parent()

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
	var projectile_scene= load(projectile_rute)
	var projectile = projectile_scene.instantiate()
	
	# Establece la posición del proyectil en el centro del sprite que dispara
	projectile.global_position = sprite_arm.global_position
	
	# Calcula la dirección basado en la rotación del nodo
	var direction = Vector2.RIGHT.rotated(rotation)
	
	# Asigna la velocidad al proyectil (asumiendo que tiene una variable velocity)
	projectile.velocity = direction * projectile_speed
	projectile.body_arm=body_arm
	# Añade el proyectil al árbol de la escena
	get_tree().root.add_child(projectile)
