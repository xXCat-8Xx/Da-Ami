extends CharacterBody3D

const SPEED = 12.420
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.1
const BOB_FREQ = 0.1
const BOB_AMP = 0.1
var t_bob = 0.0

var gravity = 9.8

@onready var körper = $MeshInstance3D
@onready var kopf = $kopf
@onready var camera = $kopf/Camera3D
@onready var pause_menü = get_node("/root/World/Node3D/Pause Menü")

var pausiert = false
var pitch := 0.0 
var yaw := 0.0    

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	toggle_pause()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * SENSITIVITY
		körper.rotation_degrees = Vector3(0, yaw, 0)
		pitch -= event.relative.y * SENSITIVITY
		pitch = clamp(pitch, -40.0, 60.0)
		kopf.rotation_degrees = Vector3(pitch, yaw, 0)
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		toggle_pause()
	if pausiert:
		return  

func _physics_process(delta: float) -> void:
	if pausiert:
		return 
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("springen") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var input_dir := Input.get_vector("links", "rechts", "nachvorn", "nachhinten")
	var direction = (kopf.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)

	move_and_slide()

func hide_pause_menu():
	pause_menü.hide()

func show_pause_menu():
	pause_menü.show()



func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time + BOB_FREQ) * BOB_AMP
	return pos

func toggle_pause():
	pausiert = !pausiert
	if pausiert:
		show_pause_menu()
		Engine.time_scale = 0 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	else:
		hide_pause_menu()
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
