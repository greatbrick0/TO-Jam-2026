extends Node3D
class_name Machine

@export var outputDirections: Array[Vector2i]
@export var inputDirections: Array[Vector2i]

@export var itemRequirements: Dictionary[ItemTypes.Items, int]
var outputInventory: Array[ItemTypes.Items] = []
var inputInventory: Array[ItemTypes.Items] = []

var layerRef: Layer
var machinePos: Vector2i

func InitMachine(newPos: Vector2i) -> void:
	machinePos = newPos
