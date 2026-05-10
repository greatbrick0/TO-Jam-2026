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
		if(HasEnoughResources()):
			StartProcess()
			ConsumeResources()
	if(!HasEnoughResources()):
		for ii in inputDirections:
			if(layerRef.machineNames.has(machinePos + ii)):
				if(layerRef.machineNames[machinePos + ii] == PlaceableBar.MachineTypes.Belt):
					layerRef.machineNodes[machinePos + ii].SlotOpened(GetRequiredResources())

func HasEnoughResources() -> bool:
	for ii in itemRequirements:
		if(inputInventory.count(ii) < itemRequirements[ii]):
			return false
	return true

func GetRequiredResources() -> Array[ItemTypes.Items]:
	var requiredItems: Array[ItemTypes.Items] = []
	for ii in itemRequirements:
		if(inputInventory.count(ii) < itemRequirements[ii]):
			requiredItems.append(ii)
	return requiredItems

func ConsumeResources() -> void:
	for ii in itemRequirements:
		for jj in itemRequirements[ii]:
			inputInventory.erase(ii)

func StartProcess() -> void:
	isProcessing = true
	$Timer.start()
	print("processing...")

func FinishProcess() -> void:
	isProcessing = false
	outputInventory.append(itemOutput)
	print("finished!")

func SlotOpened(acceptedItems: Array[ItemTypes.Items] = []) -> bool:
	if(outputInventory.is_empty()):
		return false
	else:
		MoveItem()
		return true

func MoveItem() -> void:
	var ref: Node3D = ItemTypes.itemScenes[outputInventory.pop_front()].instantiate()
	add_child(ref)
