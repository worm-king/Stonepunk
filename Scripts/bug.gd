extends Node2D

@onready var sprite = $Sprite
@onready var velocity := Vector2(0,0)
@onready var squished = false
@onready var attacking = true
@onready var taking_damage = false
@onready var squish_player = $SquishPlayer

var squish_sound


var y_variance = [0, 0, 0, 0, 0, 0]
var y_start = [-64, -36, 0, 36, 64]
var speed = 0.25
var speed_range = [0.2, 0.3, 0.4, 0.5]
var hp = 1
var strength = 1
var bounce_back := 4
var points = 1


signal received_attack()
signal dealt_attack()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AttackTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !squished:
		position.x -= speed
		position.y += y_variance.pick_random()

func initiate(level):
	squish_sound = Globals.squish_sounds.pick_random()
	squish_player.set_stream(squish_sound)
	speed = speed_range.pick_random()
	var speed_adjustment = level*0.01
	speed += speed_adjustment
	#print("this bug is level " + str(level))
	var y_pos = y_start.pick_random()
	position = Vector2(180, y_pos)
	$HitBox/Collider.disabled = false
	$AttackArea/Collider.disabled = false
	


func bug_escape():
	if squished:
		pass
	else:
		#print("the bug escaped")
		queue_free()

func attack():
	if !attacking:
		#print("sending attack info")
		attacking = true
		$AttackTimer.start()
		#return(strength)
		dealt_attack.emit(strength)
	else:
		return(0)
	

func take_damage(damage):
	if !squished:
		position.x -= bounce_back
		squish_player.play()
		if !taking_damage:
			taking_damage = true
			$DamageTimer.start()
			hp -= damage
			if hp <= 0:
				attacking = true
				#print("dead bug")
				squished = true
				speed = 0
				sprite.play("squish01")
				Globals.increment_score(points)
				#$AttackArea/Collider.disabled = true
				$DespawnTimer.start()
			else:
				#print("bug hp left: " + str(hp))
				pass


func _on_attack_timer_timeout():
	attacking = false


func _on_hit_box_area_entered(area):
	pass
	#if area.get_parent() != null && !taking_damage:
		#print("area entered detected in bug - checking if it's an attack")
		#var collision_object = area.get_parent()
		#print(collision_object)
		#taking_damage = true
		#print("player attack detected in bug - calling take_damage")
		#var player_attack = area.get_parent()
		#take_damage(player_attack.damage)
		#print("damage sent: " + str(player_attack.damage))
		#received_attack.emit()


func _on_attack_area_area_entered(area):
	if area.get_parent() != null && !(area.get_parent().has_method("do_not_count")):
		#print("attack hit Player")
		print(area)
		if area.has_method("do_not_count"):
			#print("METHOD FOUND")
			pass
		else:
			attack()
		
	#else:
		#print(area)


func _on_despawn_timer_timeout():
	queue_free()


func _on_damage_timer_timeout():
	taking_damage = false

func bug():
	#tells player attacks it's a bug
	pass


func _on_squish_player_finished():
	squish_player.stream_paused = true
