extends Node3D
class_name Machine

@export var outputDirections: Array[Vector2i]
@export var inputDirections: Array[Vector2i]

@export var itemRequirements: Dictionary[String, int]
var outputInventory: Array[String] = []
var inputInventory: Array[String] = []
