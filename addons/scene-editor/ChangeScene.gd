extends Node

export var scene := ""
export(SceneData.Type) var type := SceneData.Type.FORWARD

func change():
	SceneManager.change_scene(scene, type)
