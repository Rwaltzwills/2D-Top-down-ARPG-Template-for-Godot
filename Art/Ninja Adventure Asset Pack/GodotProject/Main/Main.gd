extends Node

@onready var hud = $Hud
@onready var life_bar = $Hud/LifeBar

func _ready():
	var player = $World/Node2D/Character
	player.connect("hit", Callable(hud, "on_player_hit"))
	life_bar.connect("dead", Callable(player, "death"))


