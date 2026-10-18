extends Area2D

var damage = 1

#signal bug_hit(bug, damage)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_player_damage(new_damage, direction):
	damage = new_damage
	if direction > 0:
		$CollisionShape2D.position.x -= 42
	else:
		pass

func _on_area_entered(area):
	
	if area.get_parent() != null:
		var bug = area.get_parent()
		if bug.has_method("bug"):
			bug.take_damage(damage)
			#print("Area entered detected in player_attack - telling bug to take damage")
		#print(bug)
		#bug_hit.emit(bug, damage)
		

func do_not_count():
	pass #don't want to count this as part of the Player's hitbox

func _on_despawn_timer_timeout():
	queue_free()
