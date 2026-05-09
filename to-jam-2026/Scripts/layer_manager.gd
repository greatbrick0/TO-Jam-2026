extends Node3D
class_name LayerManager

@export var layers: Array[Layer] = []
var activeLayerIndex: int = 1
var highestKnownLayer: int = 1

func _ready() -> void:
	for ii in get_children():
		if(!layers.has(ii)):
			layers.append(ii)
	SetActiveLayer(activeLayerIndex)

func SetActiveLayer(newLayerIndex: int) -> void:
	if(newLayerIndex < 0 or newLayerIndex > highestKnownLayer):
		return
	activeLayerIndex = newLayerIndex
	print(activeLayerIndex)
	for ii in range(len(layers)):
		layers[ii].visible = (ii <= activeLayerIndex)
		layers[ii].position.y = (ii - activeLayerIndex)

func CanPlaceObject(newPos: Vector2i, rotInt: int) -> bool:
	return layers[activeLayerIndex].CanPlaceObject(newPos, rotInt)

func PlaceObject(obj: PackedScene, newPos: Vector2i, rotInt: int) -> void:
	layers[activeLayerIndex].PlaceObject(obj, newPos, rotInt)
