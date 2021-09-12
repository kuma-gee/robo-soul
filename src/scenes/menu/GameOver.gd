extends PausedMenu

onready var sound := $GameOverSound

func _ready():
	sound.play()
