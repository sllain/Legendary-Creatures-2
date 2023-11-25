extends BaseDlg
class_name LcBaseDlg

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var loca:Loca

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(loca:Loca):
	self.loca = loca
	for i in loca.ts:
		var item = load("res://tscn/home/loca/lcLvItem.tscn").instance()
		$lvK/lvBox.add_child(item)
		item.init(i)
	tile.text = loca.name
