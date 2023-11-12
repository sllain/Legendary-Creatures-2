extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var t 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(t:LocaCastle.Tecl):
	$name.text = t.name
	self.t = t
	rLv()
	t.connect("onSetLv",self,"rLv")

func rLv():
	$lv.text = "%d级" % t.lv
