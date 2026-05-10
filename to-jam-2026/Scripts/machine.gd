extends Node3D
class_name Machine

@export var outputDirection: Vector2i
@export var inputDirections: Array[Vector2i]

@export var dropWaste: bool = false
@export var itemOutput: ItemTypes.Items = ItemTypes.Items.None
@export var itemRequirements: Dictionary[ItemTypes.Items, int]
var outputInventory: Array[ItemTypes.Items] = []
var inputInventory: Array[ItemTypes.Items] = []
var isProcessing: bool = false

var layerRef: Layer
var machinePos: Vector2i
var itemRef: Node3D 
@export var transferProgress: float = 0.0
var transferItem: ItemTypes.Items = ItemTypes.Items.None

func _ready():
	$Anim.animation_finished.connect(FinishMoving)

func InitMachine(newPos: Vector2i) -> void:
	machinePos = newPos

func _process(delta):
	if(itemRef != null):
		$TransferPoint.global_position = lerp(Vector3.ZERO, Conveyor.ConvertVector2iToSpace(outputDirection), transferProgress) + global_position
		itemRef.global_position = $TransferPoint.global_position
	if(outputInventory.is_empty() and itemOutput != ItemTypes.Items.None and !isProcessing):
		if(HasEnoughResources()):
			StartProcess()
			ConsumeResources()
	if(!HasEnoughResources()):
		for ii in inputDirections:
			if(layerRef.machineNames.has(machinePos + ii)):
				if(layerRef.machineNames[machinePos + ii] == PlaceableBar.MachineTypes.Belt):
					layerRef.machineNodes[machinePos + ii].SlotOpened(GetRequiredResources())
	if(!outputInventory.is_empty()):
		if(layerRef.machineNodes.has(machinePos + outputDirection)):
			if(!$Anim.is_playing() and layerRef.machineNodes[machinePos + outputDirection] is Conveyor):
				if(layerRef.machineNodes[machinePos + outputDirection].slotItemName == ItemTypes.Items.None):
					MoveItem()

func ClickAction() -> void:
	pass

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

func FinishProcess() -> void:
	isProcessing = false
	outputInventory.append(itemOutput)

func SlotOpened(degree: int, acceptedItems: Array[ItemTypes.Items] = []) -> bool:
	if(outputInventory.is_empty()):
		return false
	else:
		MoveItem()
		return true

func MoveItem() -> void:
	$Anim.play("Move")
	transferItem = outputInventory.pop_front()
	itemRef = ItemTypes.itemScenes[transferItem].instantiate()
	add_child(itemRef)

func FinishMoving(animName: StringName = "Move") -> void:
	var conveyor: Conveyor = layerRef.machineNodes[machinePos + outputDirection]
	itemRef.reparent(conveyor)
	conveyor.slot = itemRef
	conveyor.slotItemName = transferItem
	conveyor.itemRef = itemRef
	transferItem = ItemTypes.Items.None
	itemRef = null
