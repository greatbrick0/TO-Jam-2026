extends Node

enum Items {
	None,
	PurpleCrystal,
	GreenCrystal,
	Waste,
}

var itemScenes: Dictionary[int, PackedScene] = {
	Items.PurpleCrystal: preload("res://Scenes/item.tscn"),
	Items.GreenCrystal: preload("res://Scenes/item.tscn"),
	Items.Waste: preload("res://Scenes/item.tscn"),
	}
