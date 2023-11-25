extends LcBaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var box = $k/ScrollContainer/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(loca:Loca):
	.init(loca)
	for i in loca.chas :
		var item = load("res://tscn/home/loca/lc1_Dlg_item.tscn").instance()
		box.add_child(item)
		item.init(i,loca)
