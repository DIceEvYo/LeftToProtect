extends TextureProgressBar

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.healthChanged.connect(update)
	update()


func update():
	value = player.health*100/50
