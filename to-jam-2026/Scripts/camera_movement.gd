extends Node3D
class_name CameraMovement

var cameraMoving: bool = false
var prevMousePos: Vector2
var prevCameraPos: Vector3

@export var speedMagnitude: int = -2
@export var speedMult: Vector2 = Vector2.ONE
@export var angle: float = 20.0
@export var camSize: float = 12
@export var sizeBounds: Vector2 = Vector2(5, 20)

func OnStartCameraMove():
	cameraMoving = true
	prevMousePos = get_viewport().get_mouse_position()
	prevCameraPos = global_position

func OnStopCameraMove():
	cameraMoving = false

func RecentreCamera(newPos: Vector3) -> void:
	global_position = newPos

func _process(delta):
	if(Input.is_action_just_pressed("ZoomIn")):
		camSize -= 1
	elif(Input.is_action_just_pressed("ZoomOut")):
		camSize += 1
	camSize = max(min(camSize, sizeBounds.y), sizeBounds.x)
	$Camera3D.size = camSize
	
	if(cameraMoving):
		var mouseDifference: Vector2 = prevMousePos - get_viewport().get_mouse_position()
		var modifiedDisplacement: Vector3 = Vector3(
			mouseDifference.x * speedMult.x * pow(10, speedMagnitude) * camSize, 
			0, 
			mouseDifference.y * speedMult.y * pow(10, speedMagnitude) * camSize
			).rotated(Vector3.UP, deg_to_rad(angle))
		
		global_position = prevCameraPos + modifiedDisplacement
