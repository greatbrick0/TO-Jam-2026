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

func _process(delta):
	if(slotItemName == ItemTypes.Items.None):
		if(outputToTile == null and !inputFromTiles.is_empty()):
			SlotOpened()

func UpdateConveyor(newPos: Vector2i, layer: Layer) -> void:
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
			for ii in layer.machineNodes[pos].outputDirections:
				if(ii + pos == myPos):
					return true
			return false
	else:
		return false

func SlotOpened(acceptedItems: Array[ItemTypes.Items] = []) -> bool:
	if(slotItemName == ItemTypes.Items.None):
		PropagateOpen()
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
	if(extrasNames.is_empty()):
		PropagateOpen()
	else:
		slotItemName = extrasNames.pop_front()

func PropagateOpen() -> void:
	inputFromTiles[inputTileIndex].SlotOpened()
	inputTileIndex += 1
	inputTileIndex %= len(inputFromTiles)
