extends ScrollContainer


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
	for i in $box.get_children():
		i.queue_free()
	for i in items:
		var it = load("res://tscn/item/itemBtn.tscn").instance()
		$box.add_child(it)
		it.init(i)

