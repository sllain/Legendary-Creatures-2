extends NinePatchRect


onready var box = $ScrollContainer/HBoxContainer

var prof = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(prof):
	self.prof = prof
	$NinePatchRect/Label.text = prof
	sys.addTip($NinePatchRect,"职业会影响可以学到的技能")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func addCha(item):	
	#if item.lock == 1 :print("%s|%s|%s" % [item.name,item.tab,item.origin])
	var bt = load("res://tscn/chara/charaItem.tscn").instance()
	box.add_child(bt)
	bt.init(item)
	bt.get_node("popLv").hide()
	bt.get_node("name").hide()
	if item.lock == 1 : return
	var lbt = load("res://tscn/book/lock.tscn").instance()
	bt.add_child(lbt)
	lbt.init(item)
	lbt.position = Vector2(bt.rect_size.x * 0.5,bt.rect_size.y - 16)
	
