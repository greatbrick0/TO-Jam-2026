extends Node3D
class_name LayerManager

@export var layers: Array[Layer] = []
var activeLayerIndex: int = 1
var highestKnownLayer: int = 1

func SetActiveLayer(newLayerIndex: int) -> void:
	if(newLayerIndex < 0 or newLayerIndex > highestKnownLayer):
		return

func PlaceConveyor(newpos: Vector2i) -> void:
	pass

func PlaceMachine(newpos: Vector2i) -> void:
	pass
