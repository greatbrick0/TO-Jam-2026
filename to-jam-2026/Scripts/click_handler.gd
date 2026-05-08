extends Area3D
class_name ClickHandler

signal start_camera_move()
signal stop_camera_move()
signal click_signal(pos: Vector3)

func _on_input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int):
	if(not event is InputEventMouseButton):
		return
		
	if(event.pressed):
		if(event.button_index == MOUSE_BUTTON_LEFT):
			click_signal.emit(event_position)
		elif(event.button_index == MOUSE_BUTTON_RIGHT):
			start_camera_move.emit()
	
	elif(event.is_released()):
		if(event.button_index == MOUSE_BUTTON_RIGHT):
			stop_camera_move.emit()

func _on_mouse_exited():
	stop_camera_move.emit()
