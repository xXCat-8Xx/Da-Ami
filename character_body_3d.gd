extends CharacterBody3D


const SPEED = 12.420
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

#bob variabeln(fürs walken)
const BOB_FREQ = 0.1
const BOB_AMP = 0.1
var t_bob = 0.0

var gravity = 9.8

@onready var körper = $MeshInstance3D
@onready var kopf = $kopf
@onready var camera = $kopf/Camera3D
@onready var pause_menü = $"Node3D/Pause Menü"

var pausiert = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		PauseMenü()

func PauseMenü():
	if pausiert:
		pause_menü.hide()
		Engine.time_scale = 1
		
	else:
		pause_menü.show()
		Engine.time_scale = 0
	pausiert = !pausiert

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		körper.rotate_y(-event.relative.x * SENSITIVITY)
		kopf.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


 
	# Handle jump.
	if Input.is_action_just_pressed("springen") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("links", "rechts", "nachvorn", "nachhinten")
	var direction = (kopf.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0

# HEAD bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)



	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time + BOB_FREQ) * BOB_AMP
	return pos
