extends Area2D

signal music_changed(music)
@export var music: AudioStream = null


func _ready():
	var music_player = get_tree().get_nodes_in_group("MusicPlayer")[0]
	connect("music_changed", Callable(music_player, "_on_music_changed"))


func _on_body_entered(body):
	emit_signal("music_changed",music)
