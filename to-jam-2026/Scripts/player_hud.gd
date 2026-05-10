extends CanvasLayer

@export var layerManager: LayerManager
@export var ghostHolder: Node3D

var rotations: Array[Vector4] = [Vector4(1, 0, 1, 0), Vector4(0, -1, 0, 1), Vector4(-1, 0, -1, 0), Vector4(0, 1, 0, -1)]

@export var placeableList: Array[PlaceableBar]
var isPlacing: bool = false
var rotationIndex: int = 0
var placingIndex: int = 0
var hoveredTile: Vector2i = Vector2i.ZERO

func _process(delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		if(isPlacing):
			ResetIsPlacing()
	
	for ii in range(1, 11):
		if(Input.is_action_just_pressed(str(ii))):
			isPlacing = true
			placingIndex = ii - 1
			SetGhostHolder()
			MoveGhostHolder(hoveredTile)
	
	if(Input.is_action_just_pressed("ui_up")):
		layerManager.SetActiveLayer(layerManager.activeLayerIndex + 1)
	elif(Input.is_action_just_pressed("ui_down")):
		layerManager.SetActiveLayer(layerManager.activeLayerIndex - 1)
	
	if(isPlacing):
		if(Input.is_action_just_pressed("RotateAnti")):
			rotationIndex -= 1
			rotationIndex %= len(rotations)
			RotateGhostHolder()
		elif(Input.is_action_just_pressed("Rotate")):
			rotationIndex += 1
			rotationIndex %= len(rotations)
			RotateGhostHolder()

func ResetIsPlacing() -> void:
	isPlacing = false
	ResetGhostHolder()

func _on_hover_signal(pos):
	hoveredTile = pos
	if(isPlacing):
		MoveGhostHolder(pos)

func _on_click_signal(pos):
	if(isPlacing):
		if(!layerManager.CanPlaceObject(pos, rotationIndex, placeableList[0].names[placingIndex])):
			MusicManager.PlayGeneral(0)
			return
		layerManager.PlaceObject(placeableList[0].placeables[placingIndex], pos, rotationIndex, placeableList[0].names[placingIndex])
		MusicManager.PlayGeneral(1)
		if(placeableList[0].names[placingIndex] != PlaceableBar.MachineTypes.Belt):
			ResetIsPlacing()
	#print("click")

func SetGhostHolder() -> void:
	ResetGhostHolder()
	var ref: Node3D = placeableList[0].ghosts[placingIndex].instantiate()
	ghostHolder.add_child(ref)

func MoveGhostHolder(newPos: Vector2i) -> void:
	ghostHolder.visible = layerManager.CanPlaceObject(newPos, rotationIndex, placeableList[0].names[placingIndex])
	ghostHolder.position = Vector3(newPos.x, 0, newPos.y)

func RotateGhostHolder() -> void:
	ghostHolder.rotation = Vector3(0, rotationIndex * PI/2, 0)

func ResetGhostHolder() -> void:
	if(ghostHolder.get_child_count() > 0):
		ghostHolder.get_child(0).queue_free()
