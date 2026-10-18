extends Control

@onready var button = $Button
@onready var ani_sprite = $AniSprite
@onready var clicked = false
@onready var hovering = false

signal start_game()
# Called when the node enters the scene tree for the first time.
func _ready():
	clicked = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_just_pressed("club"):
		#print("left click and hovering in start_menu _process")
		#if !clicked:
			#clicked = true
			#ani_sprite.play("click")
			#start_game.emit()
			#$MenuSfx.play()
	pass

func _on_button_mouse_entered():
	print("hovering")
	hovering = true
	if !clicked:
		ani_sprite.play("hover")


func _on_button_mouse_exited():
	print("done hovering")
	hovering = false
	if !clicked:
		ani_sprite.play("default")



func _on_button_pressed():
	pass
	print("clicked")
	if !clicked:
		clicked = true
		ani_sprite.play("click")
		start_game.emit()
		$MenuSfx.play()
		


func _on_button_button_down():
	print("clicked")
	if !clicked:
		clicked = true
		ani_sprite.play("click")
		start_game.emit()
		$MenuSfx.play()
