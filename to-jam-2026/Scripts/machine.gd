extends Node3D
class_name Machine

@export var outputDirections: Array[Vector2i]
@export var inputDirections: Array[Vector2i]

@export var dropWaste: bool = false
@export var itemOutput: ItemTypes.Items = ItemTypes.Items.None
@export var itemRequirements: Dictionary[ItemTypes.Items, int]
var outputInventory: Array[ItemTypes.Items] = []
var inputInventory: Array[ItemTypes.Items] = []
var isProcessing: bool = false

var layerRef: Layer
var machinePos: Vector2i

func InitMachine(newPos: Vector2i) -> void:
	machinePos = newPos

func _process(delta):
	if(outputInventory.is_empty() and itemOutput != ItemTypes.Items.None and !isProcessing):
		StartProcess()

func StartProcess() -> void:
	isProcessing = true
	print("processing...")

func FinishProcess() -> void:
	isProcessing = false
