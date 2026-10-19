extends Node

@onready var squish_audio01 = load("res://Stonepunk/Audio/small squish 01.wav")
@onready var squish_audio02 = load("res://Stonepunk/Audio/small squish 02.wav")
@onready var squish_audio03 = load("res://Stonepunk/Audio/small squish 03.wav")
@onready var squish_audio04 = load("res://Stonepunk/Audio/small squish 04.wav")
@onready var squish_audio05 = load("res://Stonepunk/Audio/small squish 05.wav")

@onready var swoosh_audio01 = load("res://Stonepunk/Audio/swoosh 01.wav")
@onready var swoosh_audio02 = load("res://Stonepunk/Audio/swoosh 02.wav")

@onready var small_hit_audio01 = load("res://Stonepunk/Audio/small hit 01.wav")
@onready var small_hit_audio02 = load("res://Stonepunk/Audio/small hit 02.wav")
@onready var small_hit_audio03 = load("res://Stonepunk/Audio/small hit 03.wav")
@onready var small_hit_audio04 = load("res://Stonepunk/Audio/small hit 04.wav")
@onready var small_hit_audio05 = load("res://Stonepunk/Audio/small hit 05.wav")
@onready var small_hit_audio06 = load("res://Stonepunk/Audio/small hit 06.wav")
@onready var small_hit_audio07 = load("res://Stonepunk/Audio/small hit 07.wav")
@onready var small_hit_audio08 = load("res://Stonepunk/Audio/small hit 08.wav")
@onready var small_hit_audio09 = load("res://Stonepunk/Audio/small hit 09.wav")

@onready var big_hit_audio01 = load("res://Stonepunk/Audio/big hit 01.wav")
@onready var big_hit_audio02 = load("res://Stonepunk/Audio/big hit 02.wav")

@onready var max_hp := 5
@onready var hp := 5
@onready var score = 0

@onready var music_on = true

var squish_sounds
var swoosh_sounds
var small_hit_sounds
var big_hit_sounds
var rando_bugs = [1,1,1,1,2]

var user_interface

# Called when the node enters the scene tree for the first time.
func _ready():
	squish_sounds = [squish_audio01, squish_audio02, squish_audio03, squish_audio04, squish_audio05]
	swoosh_sounds = [swoosh_audio01, swoosh_audio02]
	small_hit_sounds = [small_hit_audio01, small_hit_audio02, small_hit_audio03, small_hit_audio04, 
	small_hit_audio05, small_hit_audio06, small_hit_audio07, small_hit_audio08, small_hit_audio09]
	big_hit_sounds = [big_hit_audio01, big_hit_audio02]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func increment_score(value):
	score += value
	user_interface.increment_score(value)
	#print(score)

func increment_hp(value):
	hp += value
	user_interface.increment_hp(value)

func game_over():
	user_interface.game_over_ui()
