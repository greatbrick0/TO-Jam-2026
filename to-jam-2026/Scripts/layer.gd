extends Node3D
class_name Layer

@export var dimensions: Vector2i = Vector2i(8, 8)

var rotations: Array[Vector4] = [Vector4(1, 0, 1, 0), Vector4(0, -1, 0, 1), Vector4(-1, 0, -1, 0), Vector4(0, 1, 0, -1)]

var machineNodes: Dictionary[Vector2i, Node3D] = {}
var machineNames: Dictionary[Vector2i, PlaceableBar.MachineTypes] = {}

func CanPlaceObject(newPos: Vector2i, rotInt: int, machineName: PlaceableBar.MachineTypes) -> bool:
	if(newPos.x > dimensions.x / 2 or newPos.x < -dimensions.x / 2):
		return false
	elif(newPos.y > dimensions.y / 2 or newPos.y < -dimensions.y / 2):
		return false
	
	if(machineNodes.has(newPos)):
		return false
	
	return true

func PlaceObject(obj: PackedScene, newPos: Vector2i, rotInt: int, machineName: PlaceableBar.MachineTypes) -> void:
	var ref: Node3D = obj.instantiate()
	add_child(ref)
	ref.position = Vector3(newPos.x, 0, newPos.y)
	machineNodes[newPos] = ref
	machineNames[newPos] = machineName
	if(machineName == PlaceableBar.MachineTypes.Belt):
		PlaceConveyor(ref, rotInt)
	else:
		PlaceMachine(ref, rotInt)

func PlaceConveyor(obj: Conveyor, rotInt: int) -> void:
	obj.rotate(Vector3.UP, rotInt * PI/2)
	

func PlaceMachine(obj: Machine, rotInt: int) -> void:
	obj.rotate(Vector3.UP, rotInt * PI/2)
