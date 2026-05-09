extends Node3D
class_name TileAdder

@export var addedTiles: Dictionary[Vector2i, Array]

func _ready():
	call_deferred("AddTiles")
	queue_free()

func AddTiles() -> void:
	var layer: Layer = get_parent()
	for ii in addedTiles:
		layer.PlaceObject(addedTiles[ii][0], ii, addedTiles[ii][1], addedTiles[ii][2])
