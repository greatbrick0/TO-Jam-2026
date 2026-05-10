extends Node

enum Items {
	None,
	PurpleCrystal,
	GreenCrystal,
	Waste,
	PurpleGem1,
	GreenGem1,
	PurpleGem2,
	GreenGem2,
	PurpleGem3,
	GreenGem3,
	Gem5,
}

var itemScenes: Dictionary[int, PackedScene] = {
	Items.PurpleCrystal: preload("res://Scenes/Items/item.tscn"),
	Items.GreenCrystal: preload("res://Scenes/Items/item.tscn"),
	Items.Waste: preload("res://Scenes/Items/item.tscn"),
	}
