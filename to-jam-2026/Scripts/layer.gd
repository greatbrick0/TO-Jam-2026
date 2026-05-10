extends Node3D
class_name Layer

@export var dimensions: Vector2i = Vector2i(8, 8)

static var rotations: Array[Vector4] = [Vector4(1, 0, 0, 1), Vector4(0, 1, -1, 0), Vector4(-1, 0, 0, -1), Vector4(0, -1, 1, 0)]

var machineNodes: Dictionary[Vector2i, Node3D] = {}
var machineNames: Dictionary[Vector2i, PlaceableBar.MachineTypes] = {}
@export var machineLimits: Dictionary[PlaceableBar.MachineTypes, int] = {}
var machineCounts: Dictionary[PlaceableBar.MachineTypes, int] = {}

func _ready() -> void:
	for ii in machineLimits:
		machineCounts[ii] = 0
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
	
	if(machineLimits.has(machineName)):
		if(machineCounts[machineName] + 1 > machineLimits[machineName]):
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
	if(machineCounts.has(machineName)):
		machineCounts[machineName] += 1
	UpdateCross(newPos)

func UpdateCross(centre: Vector2i) -> void:
	var tiles: Array[Vector2i] = [Vector2i.ZERO, Vector2i.DOWN, Vector2i.UP, Vector2i.LEFT, Vector2i.RIGHT]
	for ii in tiles:
		if(machineNames.has(centre + ii)):
			if(machineNames[centre + ii] == PlaceableBar.MachineTypes.Belt):
				machineNodes[centre + ii].UpdateConveyor(centre + ii, self)

func PlaceConveyor(obj: Conveyor, rotInt: int) -> void:
	obj.rotate(Vector3.UP, rotInt * PI/2)
	obj.outputDirection = RotateVector2i(obj.outputDirection, rotInt)

func PlaceMachine(obj: Machine, newPos: Vector2i, rotInt: int) -> void:
	obj.rotate(Vector3.UP, rotInt * PI/2)
	for ii in range(len(obj.inputDirections)):
		obj.inputDirections[ii] = RotateVector2i(obj.inputDirections[ii], rotInt)
	for ii in range(len(obj.outputDirections)):
		obj.outputDirections[ii] = RotateVector2i(obj.outputDirections[ii], rotInt)
	obj.InitMachine(newPos)

static func RotateVector2i(oldVec: Vector2i, amount: int) -> Vector2i:
	var dir: Vector2i = oldVec
	oldVec.x = (dir.x * rotations[amount].x) + (dir.y * rotations[amount].y) 
	oldVec.y = (dir.x * rotations[amount].z) + (dir.y * rotations[amount].w) 
	return oldVec
