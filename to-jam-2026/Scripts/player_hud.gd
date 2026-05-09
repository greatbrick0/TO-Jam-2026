extends CanvasLayer

@export var layerManager: LayerManager

var rotations: Array[Vector4] = [Vector4(1, 0, 1, 0), Vector4(0, -1, 0, 1), Vector4(-1, 0, -1, 0), Vector4(0, 1, 0, -1)]

@export var placeableList: Array[PlaceableBar]
var isPlacing: bool = false
var rotationIndex: int = 0
var placingIndex: int = 0

func _process(delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		if(isPlacing):
			ResetIsPlacing()
	
	for ii in range(1, 11):
		if(Input.is_action_just_pressed(str(ii))):
			isPlacing = true
			placingIndex = ii - 1
			print(ii)
	
	if(Input.is_action_just_pressed("ui_up")):
		layerManager.SetActiveLayer(layerManager.activeLayerIndex + 1)
	elif(Input.is_action_just_pressed("ui_down")):
		layerManager.SetActiveLayer(layerManager.activeLayerIndex - 1)
	
	if(isPlacing):
		if(Input.is_action_just_pressed("RotateAnti")):
			rotationIndex -= 1
			rotationIndex %= len(rotations)
		elif(Input.is_action_just_pressed("Rotate")):
			rotationIndex += 1
			rotationIndex %= len(rotations)

func ResetIsPlacing() -> void:
	isPlacing = false

func _on_hover_signal(pos):
	if(isPlacing):
		if(layerManager.CanPlaceObject(pos, rotationIndex, placeableList[0].names[placingIndex])):
			print(pos)

func _on_click_signal(pos):
	if(isPlacing):
		if(!layerManager.CanPlaceObject(pos, rotationIndex, placeableList[0].names[placingIndex])):
			MusicManager.PlayGeneral(0)
			return
		layerManager.PlaceObject(placeableList[0].placeables[placingIndex], pos, rotationIndex, placeableList[0].names[placingIndex])
		if(placingIndex != 0):
			ResetIsPlacing()
	print("click")
