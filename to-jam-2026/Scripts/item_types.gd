extends Node

enum Items {
	PurpleCrystal,
	GreenCrystal,
	Waste,
}

var itemScenes: Dictionary[Items, PackedScene] = {
	PurpleCrystal = preload("res://Scenes/item.tscn"),
	GreenCrystal = preload("res://Scenes/item.tscn"),
	Waste = preload("res://Scenes/item.tscn"),
	}
