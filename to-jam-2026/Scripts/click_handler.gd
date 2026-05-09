extends Area3D
class_name ClickHandler

signal start_camera_move()
signal stop_camera_move()
signal click_signal(pos: Vector2i)
signal hover_signal(pos: Vector2i)

var prevHoveredTile: Vector2i = Vector2i(0, 0)

func _on_input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int):
	if(not event is InputEventMouseButton):
		if(SimplifyVec(event_position) != prevHoveredTile):
			prevHoveredTile = SimplifyVec(event_position)
			hover_signal
		return
	
	if(event.is_pressed()):
		if(event.button_index == MOUSE_BUTTON_LEFT):
			print(event_position)
			click_signal.emit(SimplifyVec(event_position))
		elif(event.button_index == MOUSE_BUTTON_RIGHT):
			start_camera_move.emit()
	elif(event.is_released()):
		if(event.button_index == MOUSE_BUTTON_RIGHT):
			stop_camera_move.emit()

func _on_mouse_exited():
	stop_camera_move.emit()

func SimplifyVec(oldVec: Vector3) -> Vector2i:
	var output: Vector2i = Vector2i(0, 0)
	output.x = round(oldVec.x)
	output.y = round(oldVec.z)
	return output
