extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var id = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(cha,id):
	$name.text = cons.attDs[id].name
	self.id = id
	sys.addTip(self,cons.attDs[id].dec)

func up(val):
	if cons.attDs[id].isPer :
		$Label.text = "%d%%" % (val * 100)
	else:
		$Label.text = "%d" % val
	if id == "def" || id == "mdef":
		sys.addTip(self,"%s %d%%" % [tr(cons.attDs[id].dec),val/(val+cons.defCoe) * 100])
	else:
		sys.addTip(self,cons.attDs[id].dec)
