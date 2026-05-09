extends Node3D
class_name LayerManager

@export var layers: Array[Layer] = []
var activeLayerIndex: int = 1
var highestKnownLayer: int = 1

func SetActiveLayer(newLayerIndex: int) -> void:
	if(newLayerIndex < 0 or newLayerIndex > highestKnownLayer):
		return

func PlaceObject(obj: PackedScene, newPos: Vector2i, rotMatrix: Vector4) -> void:
	layers[activeLayerIndex].PlaceObject(obj, newPos, rotMatrix)
