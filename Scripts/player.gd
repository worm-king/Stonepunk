extends CharacterBody2D


const SPEED = 2500.0
const JUMP_VELOCITY = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player_audio = $PlayerAudio
@onready var sprite_2d = $AnimatedSprite2D
@onready var hit_box_base = $HitBoxBase

@onready var taking_damage := false
@onready var hp := 5
@onready var attacking = false
@onready var attack_damage := 1
@onready var attack_scene := preload("res://Stonepunk/Scenes/player_attack.tscn")

signal death()

var x_direction = 1

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		##velocity.y += gravity * delta
		#pass

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		##velocity.y = JUMP_VELOCITY
		#pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	#need: 
	#if direction x is negative (left) and !attacking, play walk with animated sprite flipped horiz
	#if direction x is positive (right) and !attacking, play walk with animated sprite NOT flipped
	#if directrion x i 0 but y is not 0, and !attacking, play walk and don't look at the flip
	#if direction x and y are 0 and not attack, play idle and don't look at flip
	if !attacking && direction_x < 0:
		#print("walk")
		sprite_2d.flip_h = true
		sprite_2d.play("walk01")
		hit_box_base.position.x = -6
		x_direction = -1
	elif !attacking && direction_x > 0:
		sprite_2d.flip_h = false
		sprite_2d.play("walk01")
		hit_box_base.position.x = 6
		x_direction = 1
	elif !attacking && direction_y !=0:
		sprite_2d.play("walk01")
	elif !attacking && direction_x == 0 && direction_y == 0:
		#print("idle")
		sprite_2d.play("idle01")
	
	if direction_x != 0:
		#print("move X")
		if !attacking:
			velocity.x = direction_x * SPEED * delta
		else:
			velocity.x = direction_x * SPEED * 0.5 * delta
		#print(velocity)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction_y != 0:
		#print("moveY")
		if !attacking:
			velocity.y = direction_y * SPEED * delta
		else:
			velocity.y = direction_y * SPEED * 0.5 * delta
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()

func _process(delta):
	if !attacking && Input.is_action_just_pressed("club"):
		#print("use club")
		player_audio.stream = Globals.swoosh_sounds.pick_random()
		player_audio.play()
		$HitBoxBase/CollisionShape2D.disabled = true
		$HitBoxAttacking/HitBoxCollider.disabled = false
		attacking = true
		sprite_2d.play("club01")
		$AttackingTimer.start()
		var new_attack = attack_scene.instantiate()
		$Attacks.add_child(new_attack)
		new_attack.set_player_damage(attack_damage, -x_direction)



#this should be handled in Level scene
#func _on_hit_box_base_area_entered(area):
	#print("Player area entered")
	#if area.has_method("attack") && !taking_damage:
		#var damage_taken = area.attack()
		#print("took damage:   " + str(damage_taken))
		#if damage_taken > 0:
			#taking_damage = true
			#$DamageTimer.start()

func received_attack(damage):
	if !taking_damage:
		taking_damage = true
		$DamageTimer.start()
		if damage > 0:
			position.x -= x_direction * 4
		Globals.increment_hp(-damage)
		#should add audio here
		hp -= damage
		print("hp : " + str(hp))
		if hp <= 0:
			death.emit()
			#print("emitting death signal from player")
		else:
			pass
			#print("damage taken by Player:   " + str(damage))

func _on_damage_timer_timeout():
	taking_damage = false


func _on_attacking_timer_timeout():
	attacking = false
	$HitBoxBase/CollisionShape2D.disabled = false
	$HitBoxAttacking/HitBoxCollider.disabled = true
