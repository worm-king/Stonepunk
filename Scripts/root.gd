extends Node

var menu_scene := preload("res://Stonepunk/Scenes/start_menu.tscn")
var level_scene := preload("res://Stonepunk/Scenes/level.tscn")

func _ready():
	load_start_menu()

func load_start_menu():
	print("running load_start_menu")
	var menus = get_tree().get_nodes_in_group("menu")
	#var levels = get_tree().get_nodes_in_group("level")
	for n in menus:
		n.queue_free()
	#for m in levels:
		#m.queue_free()
	
	var menu = menu_scene.instantiate()
	call_deferred("add_child", menu)
	menu.call_deferred("connect", "start_game", _on_start_game)
	get_tree().paused = false


func _on_start_game():
	print("starting game")
	$StartGameTimer.start()


func _on_timer_timeout():
	var menus = get_tree().get_nodes_in_group("menu")
	for n in menus:
		n.queue_free()
		print("deleted menu")
	
	var new_level = level_scene.instantiate()
	call_deferred("add_child", new_level)
	new_level.call_deferred("connect", "game_over", _on_game_over)

func _on_game_over():
	var levels = get_tree().get_nodes_in_group("level")
	for m in levels:
		m.queue_free()
	
	var menus = get_tree().get_nodes_in_group("menu")
	for n in menus:
		n.queue_free()
		print("deleted menu")
	
	load_start_menu()
