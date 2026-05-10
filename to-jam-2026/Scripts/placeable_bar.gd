extends Resource
class_name PlaceableBar

enum MachineTypes {
	Belt,
	Drill,
	Polisher,
	Lava,
	PurpleCrystal,
	GreenCrystal,
}

@export var placeables: Array[PackedScene]
@export var ghosts: Array[PackedScene]
@export var names: Array[MachineTypes]
