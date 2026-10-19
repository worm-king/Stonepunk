extends Node2D

@onready var sprite = $Sprite
@onready var velocity := Vector2(0,0)
@onready var squished = false
@onready var attacking = true
@onready var taking_damage = false
@onready var squish_player = $SquishPlayer
@onready var delta_mod = 100

var squish_sound
var squish_ani = "squish01"
var hit_tween

var y_variance = [0, 0, 0, 0, 0, 0]
var y_start = [-64, -36, 0, 36, 64]
var speed = 0.25
var speed_range = [0.2, 0.3, 0.4, 0.5]
var hp = 1
var strength = 1
var bounce_back := 4
var points = 1
var rando_bug_list = [1,1,1,1,2]

signal received_attack()
signal dealt_attack()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AttackTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !squished:
		position.x -= speed*delta*delta_mod
		position.y += y_variance.pick_random()

func initiate(level):
	rando_bug_list = Globals.rando_bugs
	squish_sound = Globals.squish_sounds.pick_random()
	squish_player.set_stream(squish_sound)
	speed = speed_range.pick_random()
	var speed_adjustment = level*0.01
	speed += speed_adjustment
	#print("this bug is level " + str(level))
	var y_pos = y_start.pick_random()
	position = Vector2(180, y_pos)
	if level >= 10:
		
		var bug_type = rando_bug_list.pick_random()
		var new_num = [1]
		if level <=15:
			new_num = [1,1,1,2,2,2,3]
		elif level > 15 && level < 21:
			new_num = [1,2,2,2,3,3,3]
		elif level >= 21:
			new_num = [2,2,2,3,3,3,3,3,3]
		
		Globals.rando_bugs.append(new_num.pick_random())
		#print(rando_bug_list)
		match bug_type:
			1: 
				#print("chonker")
				#sprite.play("walk03")
				#squish_ani = "squish03"
				#points = 25
				#strength = 2
				#hp = 3
				#$BigHitBox/Collider.disabled = false
				print("little bug")
				sprite.play("walk01")
				squish_ani = "squish01"
				points = 1
				strength = 1
				hp = 1
				$BigHitBox/Collider.disabled = true
			2: 
				print("big bug")
				sprite.play("walk02")
				squish_ani = "squish02"
				points = 5
				strength = 2
				hp = 2
				$BigHitBox/Collider.disabled = true
			3:
				print("chonker")
				sprite.play("walk03")
				squish_ani = "squish03"
				points = 25
				strength = 2
				hp = 3
				$BigHitBox/Collider.disabled = false
	$HitBox/Collider.disabled = false
	$AttackArea/Collider.disabled = false
	


func bug_escape():
	if squished:
		pass
	else:
		#print("the bug escaped")
		queue_free()

func attack():
	if !attacking && !squished:
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
		#print(squish_player.stream)
		if !taking_damage:
			taking_damage = true
			$DamageTimer.start()
			hp -= damage
			if hp <= 0:
				attacking = true
				#print("dead bug")
				squished = true
				speed = 0
				sprite.play(squish_ani)
				Globals.increment_score(points)
				#$AttackArea/Collider.disabled = true
				$DespawnTimer.start()
			else:
				tweening_hit()


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
	pass
	#squish_player.stream_paused = true

func tweening_hit():
	hit_tween = create_tween() 
	hit_tween.tween_property(sprite, "modulate", Color.DARK_RED, 0.3) 
	hit_tween.tween_property(sprite, "modulate", Color.WHITE, 0.3)

func do_not_count():
	pass


func _on_end_timer_timeout():
	queue_free()
