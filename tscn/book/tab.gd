extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var box = $ScrollContainer/GridContainer
# Called when the node enters the scene tree for the first time.
var isShow = false
func init():
	if isShow : return
	isShow = true
	if name == "单位" :
		for i in data.getList("c") :
			var item = data.newBase(i.id)
			if item.lock == -1 :continue
			var bt = load("res://tscn/chara/charaItem.tscn").instance()
			bt.get_node("popLv").hide()
			bt.get_node("name").hide()
			addItem(item,bt)
	elif name == "技能" :
		for i in data.getList("k") :
			var item = data.newBase(i.id)
			if item.lock == -1 :continue
			var bt = load("res://tscn/charaDlg/skill/skillBtn.tscn").instance()
			addItem(item,bt)
			bt.initTip()
			
	elif name == "物品" :
		for i in data.getList("csb") :
			var item = data.newBase(i.id)
			if item.lock == -1 :continue
			var bt = load("res://tscn/item/itemBtn.tscn").instance()
			addItem(item,bt)
		for i in data.getList("gem") :
			var item = data.newBase(i.id)
			if item.lock == -1 :continue
			if item.isUnique == true :
				item.lv = 4
			var bt = load("res://tscn/item/itemBtn.tscn").instance()
			addItem(item,bt)
		for i in data.getList("eqp") :
			var item = data.newBase(i.id)
			if item.lock == -1 :continue
			var bt = load("res://tscn/item/itemBtn.tscn").instance()
			addItem(item,bt)
	elif name == "设施" :
		for i in data.getList("faci") :
			var item = data.newBase(i.id)
			if item.lock == -1 :continue
			if item.id.split("_").size() > 2 : continue
			var bt = load("res://tscn/book/faciBtn.tscn").instance()
			addItem(item,bt)
			bt.init(item)
	elif name == "神徽" :
		for i in data.getList("r") :
			var item = data.newBase(i.id)
			if item.lock == -1 :continue
			var bt = load("res://tscn/book/faciBtn.tscn").instance()
			addItem(item,bt)
			bt.init(item)		

func addItem(item,bt):
	box.add_child(bt)
	bt.init(item)
	if item.lock == 1 : return
	var lbt = load("res://tscn/book/lock.tscn").instance()
	bt.add_child(lbt)
	lbt.init(item)
	lbt.position = Vector2(bt.rect_size.x * 0.5,bt.rect_size.y - 16)
	#lbt.init(item)

func _on_tab_draw():
	init()

func SetAllDisable(bl) :
	for i in box.get_children():
		if i.has_node("lock") :
			i.get_node("lock").setDisable(true)
