extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var box = $ScrollContainer/GridContainer
var items
signal onPressed(item)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var type = 0
var exItems = null
var isOnly = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
# 0:全部 1：装备 2：消耗品 3：材料 4：宝石
func init(items,type = 0,exItems = null,isOnly = true):
	self.type = type
	self.items = items
	self.exItems = exItems
	self.isOnly = isOnly
	items.connect("onAddItem",self,"addItem")
	itemSort()
	sels()
	
func itemSort():
	items.items.sort_custom(self,"sort_ascending")

static func sort_ascending(a, b):
		if a.lv > b.lv:
			return true
		return false
	
func addItem(item,inx):
	if isSel(item) == false: return
	var itemBtn = preload("res://tscn/item/itemBtn.tscn").instance()
	box.add_child(itemBtn)
	itemBtn.isDrag = true
	itemBtn.init(item)
	itemBtn.connect("pressed",self,"rPressed",[item])
	
func rPressed(item):
	if Input.is_action_pressed("ui_ctrl") :
		$sell.sell(item)
	else:
		emit_signal("onPressed",item)

func sels():
	for i in box.get_children():
		i.queue_free()
	for  i in items.items:
		addItem(i,-1)
	
func isSel(item):
	if item is Mater  && item.isHomeShow == true:
		return false
	if exItems != null:
		for i in exItems.items:
			if i == item :return false
	var bl = true
	if type == 5 : 
		if item is Gem || item is Mater :
			return true
		else:
			return false
	if isOnly == false && item.isOnly == true: bl = false
	if type == 1 && item is Eqp == false :bl = false
	if type == 2 && item is Csb == false :bl = false
	if type == 3 && item is Mater == false :bl = false
	if type == 4 && item is Gem == false :bl = false
	return bl
	
func _on_Button_pressed():
	type = 0
	sels()

func _on_Button2_pressed():
	type = 1
	sels()

func _on_Button3_pressed():
	type = 2
	sels()


func _on_Button4_pressed():
	type = 5
	sels()
