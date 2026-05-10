extends Machine

func InitMachine(newPos: Vector2i) -> void:
	machinePos = newPos
	SetItemOutput()

func SetItemOutput() -> void:
	var lookingAtTile: Vector2i = machinePos + (outputDirection * -1)
	print(str(machinePos) + " looking at " + str(lookingAtTile) + " using " + str(outputDirection))
	if(!layerRef.machineNames.has(lookingAtTile)):
		return
	
	if(layerRef.machineNames[lookingAtTile] == PlaceableBar.MachineTypes.PurpleCrystal):
		itemOutput = ItemTypes.Items.PurpleCrystal
	elif(layerRef.machineNames[lookingAtTile] == PlaceableBar.MachineTypes.GreenCrystal):
		itemOutput = ItemTypes.Items.GreenCrystal
