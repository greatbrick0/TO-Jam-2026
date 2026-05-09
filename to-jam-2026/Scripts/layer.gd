extends Node3D
class_name Layer

func _ready():
	pass 

func _process(delta):
	pass

func PlaceObject(obj: PackedScene, newPos: Vector2i, rotMatrix: Vector4) -> void:
	var ref: Node3D = obj.instantiate()
	add_child(ref)
	ref.position = Vector3(newPos.x, 0, newPos.y)
