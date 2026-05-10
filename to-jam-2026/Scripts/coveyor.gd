extends Node3D
class_name Conveyor

var slot: Node3D
var slotItemName: ItemTypes.Items = ItemTypes.Items.None

var extras: Array[Node3D] = []
var extrasNames: Array[ItemTypes.Items] = []

var outputToTile: Node3D = null
var inputFromTiles: Array[Node3D] = []
var inputTileIndex: int = 0

func _process(delta):
	if(slotItemName == ItemTypes.Items.None):
		if(outputToTile == null and !inputFromTiles.is_empty()):
			SlotOpened()

func SlotOpened(acceptedItems: Array[ItemTypes.Items] = []) -> bool:
	if(slotItemName == ItemTypes.Items.None):
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
		inputFromTiles[inputTileIndex].SlotOpened()
		inputTileIndex += 1
		inputTileIndex %= len(inputFromTiles)
	else:
		slotItemName = extrasNames.pop_front()
