extends "res://tscn/item/itemDlg.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var items 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(items):
	.init(items)
	self.items = items
	upWeight()
	
func upWeight():
	$weightBar/val.text = "%d/%d" % [items.weight,sys.player.maxWeight]
	$weightBar.value = items.weight
	$weightBar.max_value = sys.player.maxWeight
