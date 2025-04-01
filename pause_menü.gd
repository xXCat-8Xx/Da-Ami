extends Control

@onready var main = $"Node3D/Pause Menü"

func _on_quit_pressed() -> void:
	get_tree().quit()



func _on_resume_pressed() -> void:
	main.PauseMenü()
