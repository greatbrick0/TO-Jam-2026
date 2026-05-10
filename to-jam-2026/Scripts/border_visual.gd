extends Node3D
class_name BorderVisual

@export var cornerExtra: float = 0.1

func SetBorders(newSize: Vector2i) -> void:
	$Down.scale.x = newSize.x + (cornerExtra * 2)
	$Down.position.z = -(newSize.y) / 2
	$Up.scale.x = newSize.x + (cornerExtra * 2)
	$Up.position.z = (newSize.y) / 2
	$Left.scale.z = newSize.y + (cornerExtra * 2)
	$Left.position.x = -(newSize.x) / 2
	$Right.scale.z = newSize.y + (cornerExtra * 2)
	$Right.position.x = (newSize.x) / 2
	
