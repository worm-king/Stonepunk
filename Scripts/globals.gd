extends Node

@onready var squish_audio01 = load("res://Stonepunk/Audio/small squish 01.wav")
@onready var squish_audio02 = load("res://Stonepunk/Audio/small squish 02.wav")
@onready var squish_audio03 = load("res://Stonepunk/Audio/small squish 03.wav")
@onready var squish_audio04 = load("res://Stonepunk/Audio/small squish 04.wav")
@onready var squish_audio05 = load("res://Stonepunk/Audio/small squish 05.wav")

@onready var swoosh_audio01 = load("res://Stonepunk/Audio/swoosh 01.wav")
@onready var swoosh_audio02 = load("res://Stonepunk/Audio/swoosh 02.wav")

@onready var max_hp := 5
@onready var hp := 5
@onready var score = 0

var squish_sounds
var swoosh_sounds

var user_interface

# Called when the node enters the scene tree for the first time.
func _ready():
	squish_sounds = [squish_audio01, squish_audio02, squish_audio03, squish_audio04, squish_audio05]
	swoosh_sounds = [swoosh_audio01, swoosh_audio02]


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
