extends Node3D

@onready var pause_menü = $"Node3D/Pause Menü"  # Referenz auf das Pause-Menü
var pausiert = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):  # Überprüfe, ob die "Pause"-Taste gedrückt wurde
		PauseMenü()  # Aufruf der Funktion zum Pausieren oder Fortsetzen des Spiels

func PauseMenü():
	if pausiert:
		pause_menü.hide()  # Verstecke das Menü
		Engine.time_scale = 1  # Setze die Zeit zurück, sodass das Spiel weiterläuft
	else:
		pause_menü.show()  # Zeige das Menü
		Engine.time_scale = 0  # Pausiere das Spiel
	pausiert = !pausiert  # Wechsle den Pausenstatus
