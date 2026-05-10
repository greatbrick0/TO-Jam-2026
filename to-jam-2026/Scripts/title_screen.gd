extends Node

@export var gameplayScene: PackedScene

func PlayStartAnimation() -> void:
	MusicManager.PlayGeneral(1)
	$StartAnimator.play("Start")

func TransitionToGameplayScene() -> void:
	get_tree().change_scene_to_packed(gameplayScene)

func Quit() -> void:
	get_tree().quit()
