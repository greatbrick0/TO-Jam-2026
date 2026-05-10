extends Machine

func InitMachine(newPos: Vector2i) -> void:
	machinePos = newPos
	
	var lookingAtTile: Vector2i = machinePos + (-outputDirections[0])
	if(layerRef.machineNames.has(lookingAtTile)):
		return
	
	if(layerRef.machineNames[lookingAtTile] == PlaceableBar.MachineTypes.PurpleCrystal):
		itemOutput = ItemTypes.Items.PurpleCrystal
	elif(layerRef.machineNames[lookingAtTile] == PlaceableBar.MachineTypes.GreenCrystal):
		itemOutput = ItemTypes.Items.GreenCrystal
