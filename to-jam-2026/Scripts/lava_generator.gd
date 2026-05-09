extends TileAdder

@export var lavaScene: PackedScene
@export var bounds: Vector2i

func _ready():
	GenerateLava()
	call_deferred("AddTiles")
	queue_free()

func GenerateLava() -> void:
	for ii in bounds.x:
		for jj in bounds.y:
			addedTiles[Vector2i(ii - bounds.x/2, jj - bounds.y/2)] = [lavaScene, 0, PlaceableBar.MachineTypes.Lava]
