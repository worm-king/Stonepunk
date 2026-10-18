extends Node2D

@onready var player = $YSort/Player
@onready var bugs = $YSort/Bugs

@onready var current_level = 1
@onready var bug_scene := preload("res://Stonepunk/Scenes/bug.tscn")

signal game_over()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spawn_bug():
	current_level += 1
	var new_bug = bug_scene.instantiate()
	bugs.add_child(new_bug)
	new_bug.initiate(current_level)
	new_bug.connect("dealt_attack", _on_bug_dealt_attack)
	#new_bug.connect("received_attack", _on_bug_received_attack)

func _on_bug_dealt_attack(val):
	#print("Level received the bug's attack of: " + str(val))
	player.received_attack(val)


func _on_bug_spawn_timer_timeout():
	if $BugSpawnTimer.wait_time > 0.5:
		$BugSpawnTimer.wait_time = $BugSpawnTimer.wait_time*0.95
	spawn_bug()
	


func _on_player_death():
	print("game over")
	print("Final score: " + str(Globals.score))
	get_tree().paused = true
	$GameOverTimer.start()
	


func _on_game_over_timer_timeout():
	game_over.emit()
	queue_free()
