extends CanvasLayer

@export var layerManager: LayerManager

var isPlacing: bool = false

func _process(delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		if(isPlacing):
			isPlacing = false
	
	for ii in range(1, 11):
		if(Input.is_action_just_pressed(str(ii))):
			isPlacing = true
			print(ii)
	
	if(Input.is_action_just_pressed("ui_up")):
		print("up")
	elif(Input.is_action_just_pressed("ui_down")):
		print("down")
	
	if(isPlacing):
		if(Input.is_action_just_pressed("RotateAnti")):
			print("antirotate")
		elif(Input.is_action_just_pressed("Rotate")):
			print("rotate")

func _on_hover_signal(pos):
	if(isPlacing):
		print(pos)

func _on_click_signal(pos):
	print("click")
