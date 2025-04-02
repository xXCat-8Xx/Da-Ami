extends Control
@onready var main = get_node("/root/World/Node3D/CharacterBody3D")  # Zugriff auf den CharacterBody3D Node
@onready var pause_menü = get_node("/root/World/Node3D/Pause Menü")  # Referenz auf das Pause-Menü

func _on_quit_pressed() -> void:
	get_tree().quit()  # Beendet das Spiel, wenn der Quit-Button gedrückt wird

func _on_resume_pressed() -> void:
	main.toggle_pause()  # Ruft die toggle_pause() Funktion aus CharacterBody3D auf, um das Spiel fortzusetzen
	pause_menü.hide()  # Versteckt das Pausenmenü
