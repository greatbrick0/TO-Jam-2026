extends Node3D
class_name LayerManager

@export var borderVisual: BorderVisual
@export var layers: Array[Layer] = []
var activeLayerIndex: int = 1
@export var highestKnownLayer: int = 1

func _ready() -> void:
	for ii in get_children():
		if(!layers.has(ii)):
			layers.append(ii)
	SetActiveLayer(activeLayerIndex)

func SetActiveLayer(newLayerIndex: int) -> void:
	if(newLayerIndex < 0 or newLayerIndex > highestKnownLayer):
		return
	activeLayerIndex = newLayerIndex
	print("layer " + str(activeLayerIndex))
	if(!(layers[activeLayerIndex].dimensions.x == 0 or layers[activeLayerIndex].dimensions.y == 0)):
		borderVisual.SetBorders(layers[activeLayerIndex].dimensions)
	for ii in range(len(layers)):
		layers[ii].visible = (ii <= activeLayerIndex)
		layers[ii].position.y = (ii - activeLayerIndex)

func CanPlaceObject(newPos: Vector2i, rotInt: int, machineName: PlaceableBar.MachineTypes) -> bool:
	return layers[activeLayerIndex].CanPlaceObject(newPos, rotInt, machineName)

func PlaceObject(obj: PackedScene, newPos: Vector2i, rotInt: int, machineName: PlaceableBar.MachineTypes) -> void:
	layers[activeLayerIndex].PlaceObject(obj, newPos, rotInt, machineName)
