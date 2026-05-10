extends Node3D
class_name Conveyor

var slot: Node3D
var slotItemName: ItemTypes.Items = ItemTypes.Items.None

var extras: Array[Node3D] = []
var extrasNames: Array[ItemTypes.Items] = []

var outputDirection: Vector2i = Vector2i(0, 1)
var outputToTile: Node3D = null
var inputFromTiles: Array[Node3D] = []
var inputTileIndex: int = 0

var itemRef: Node3D 
@export var transferProgress: float = 0.0
var transferItem: ItemTypes.Items = ItemTypes.Items.None

func _process(delta):
	if(itemRef != null):
		$TransferPoint.global_position = lerp(Vector3.ZERO, Conveyor.ConvertVector2iToSpace(outputDirection), transferProgress) + global_position
		itemRef.global_position = $TransferPoint.global_position
	if(!$Anim.is_playing() and outputToTile != null):
		if(outputToTile is Conveyor):
			if(outputToTile.slotItemName == ItemTypes.Items.None):
				MoveItem()

func UpdateConveyor(newPos: Vector2i, layer: Layer) -> void:
	if(layer.machineNames.has(newPos + outputDirection)):
		outputToTile = layer.machineNodes[newPos + outputDirection]
	else:
		outputToTile = null
	
	inputFromTiles.clear()
	if(DoesInputToMe(newPos + Layer.RotateVector2i(outputDirection, 2), newPos, layer)):
		SetVisuals("Straight")
		inputFromTiles.append(layer.machineNodes[newPos + Layer.RotateVector2i(outputDirection, 2)])
	elif(DoesInputToMe(newPos + Layer.RotateVector2i(outputDirection, 1), newPos, layer) and DoesInputToMe(newPos + Layer.RotateVector2i(outputDirection, 3), newPos, layer)):
		SetVisuals("Straight")
		inputFromTiles.append(layer.machineNodes[newPos + Layer.RotateVector2i(outputDirection, 1)])
		inputFromTiles.append(layer.machineNodes[newPos + Layer.RotateVector2i(outputDirection, 3)])
	elif(DoesInputToMe(newPos + Layer.RotateVector2i(outputDirection, 1), newPos, layer)):
		SetVisuals("Right")
		inputFromTiles.append(layer.machineNodes[newPos + Layer.RotateVector2i(outputDirection, 1)])
	elif(DoesInputToMe(newPos + Layer.RotateVector2i(outputDirection, 3), newPos, layer)):
		SetVisuals("Left")
		inputFromTiles.append(layer.machineNodes[newPos + Layer.RotateVector2i(outputDirection, 3)])
	else:
		SetVisuals("Straight")

func ClickAction() -> void:
	print("holding ", slotItemName)

func SetVisuals(selected: String) -> void:
	for ii in $Visuals.get_children():
		ii.visible = ii.name == selected

func DoesInputToMe(pos: Vector2i, myPos: Vector2i, layer: Layer) -> bool:
	if(layer.machineNames.has(pos)):
		if(layer.machineNames[pos] == PlaceableBar.MachineTypes.Belt):
			if(layer.machineNodes[pos].outputDirection + pos == myPos):
				return true
			else:
				return false
		else:
			if(layer.machineNodes[pos].outputDirection + pos == myPos):
				return true
			else:
				return false
	else:
		return false

func SlotOpened(degree: int, acceptedItems: Array[ItemTypes.Items] = []) -> bool:
	if(slotItemName == ItemTypes.Items.None):
		PropagateOpen(degree + 1)
		return false
	if(acceptedItems.is_empty()):
		MoveItem()
		return true
	else:
		if(acceptedItems.has(slotItemName)):
			MoveItem()
			return true
		else:
			return false

func MoveItem() -> void:
	if($Anim.is_playing()):
		return
	if(outputToTile != null):
		$Anim.play("Move")
		if(extrasNames.is_empty()):
			PropagateOpen(0)
		else:
			slotItemName = extrasNames.pop_front()
			slot = extras.pop_front()

func PropagateOpen(degree: int) -> void:
	if(inputFromTiles.is_empty()):
		return
	inputFromTiles[inputTileIndex].SlotOpened(degree)
	inputTileIndex += 1
	inputTileIndex %= len(inputFromTiles)

func FinishMoving(animName: StringName = "Move") -> void:
	itemRef.reparent(outputToTile)
	if(outputToTile is Conveyor):
		outputToTile.slot = itemRef
		outputToTile.slotItemName = transferItem
		outputToTile.itemRef = itemRef
	else:
		outputToTile.inputInventory.append(transferItem)
		itemRef.queue_free()
	transferItem = ItemTypes.Items.None
	itemRef = null

static func ConvertVector2iToSpace(oldVec: Vector2i) -> Vector3:
	return Vector3(oldVec.x, 0, oldVec.y)
