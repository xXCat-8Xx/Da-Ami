extends Control

func Resume():
	get_tree().paused = false

func Resume():
	get_tree().paused = true

func Esc():
	if Input.is_action_just_pressed("escape") and get_tree() == false:
		paused()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
		Resume()




func _on_resume_pressed() -> void:
	Resume()


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
