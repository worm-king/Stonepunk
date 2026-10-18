extends Control

@onready var max_hp = 5
@onready var current_hp = 5
@onready var score = 0
@onready var hp_bar = $HpBar
@onready var score_label = $ScoreLabel



# Called when the node enters the scene tree for the first time.
func _ready():
	hp_bar.value = max_hp
	Globals.user_interface = $"."
	score_label.text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func increment_hp(value):
	current_hp += value
	if current_hp > max_hp:
		current_hp = max_hp
		#could check for game over here
	hp_bar.value = current_hp

func increment_score(value):
	score += value
	score_label.text = str(score)
