extends Node2D
@onready var bug_area = $BugArea


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bug_area_area_entered(area):
	pass
	#print(area)
	#print(area.get_parent())
	#area.get_parent().bug_escape()
