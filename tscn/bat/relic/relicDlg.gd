extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(items):
	for i in items:
		var bt = preload("res://tscn/item/relicBtn.tscn").instance()
		$items/box.add_child(bt)
		bt.init(i)
