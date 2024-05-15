extends Node

@export var animation_player: AnimationPlayer

enum TransitionType {FADE}

func transition(type: TransitionType, scene:String):
	match type:
		TransitionType.FADE:
			fade(scene)

func fade(scene:String):
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene)
	animation_player.play("fade_in")

