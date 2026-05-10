extends Node3D
class_name Layer

@export var dimensions: Vector2i = Vector2i(8, 8)

var rotations: Array[Vector4] = [Vector4(1, 0, 0, 1), Vector4(0, 1, -1, 0), Vector4(-1, 0, 0, -1), Vector4(0, -1, 1, 0)]

var machineNodes: Dictionary[Vector2i, Node3D] = {}
var machineNames: Dictionary[Vector2i, PlaceableBar.MachineTypes] = {}

func _ready() -> void:
	for ii in get_children():
		if(ii is TileAdder):
			ii.Initialize()

func CanPlaceObject(newPos: Vector2i, rotInt: int, machineName: PlaceableBar.MachineTypes) -> bool:
	if(newPos.x > (dimensions.x - 1) / 2 or newPos.x < -dimensions.x / 2):
		return false
	elif(newPos.y > (dimensions.y - 1) / 2 or newPos.y < -dimensions.y / 2):
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
		ref.layerRef = self
		PlaceMachine(ref, newPos, rotInt)

func PlaceConveyor(obj: Conveyor, rotInt: int) -> void:
	obj.rotate(Vector3.UP, rotInt * PI/2)

func PlaceMachine(obj: Machine, newPos: Vector2i, rotInt: int) -> void:
	obj.rotate(Vector3.UP, rotInt * PI/2)
	for ii in range(len(obj.inputDirections)):
		var dir: Vector2i = obj.inputDirections[ii]
		obj.inputDirections[ii].x = (dir.x * rotations[rotInt].x) + (dir.y * rotations[rotInt].y) 
		obj.inputDirections[ii].y = (dir.x * rotations[rotInt].z) + (dir.y * rotations[rotInt].w) 
	for ii in range(len(obj.outputDirections)):
		var dir: Vector2i = obj.outputDirections[ii]
		obj.outputDirections[ii].x = (dir.x * rotations[rotInt].x) + (dir.y * rotations[rotInt].y) 
		obj.outputDirections[ii].y = (dir.x * rotations[rotInt].z) + (dir.y * rotations[rotInt].w)
	obj.InitMachine(newPos)
