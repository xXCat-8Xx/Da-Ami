extends Node3D
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
