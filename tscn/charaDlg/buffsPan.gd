extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(cha):
	for i in cha.affs:
		if i.isDel == false: _addBuff(i)
	cha.connect("onAddBuff",self,"_addBuff")

func _addBuff(buff:Buff):
	if buff == null:return
	if buff.isVis == false || buff.icoId == "" || buff.isDel:return
	for i in get_children():
		if i.bf.id == buff.id :
			return
	var btn = load("res://tscn/charaDlg/buffBtn.tscn").instance()
	add_child(btn)
	btn.init(buff)
