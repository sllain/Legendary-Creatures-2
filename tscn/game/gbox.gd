extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func init():
	for i in sys.game.globals:
		var g = sys.game.globals[i]
		var bt = preload("res://tscn/game/gBtn.tscn").instance()
		add_child(bt)
		bt.init(g)
		
