extends BaseDlg
class_name EventDlg

signal onSel(info)

onready var box = $ScrollContainer/VBoxContainer
var inx = 0
func _ready():
	hide()

func txt(txt,isNext = false):
	var list = load("res://tscn/eventDlg/eventTxt.tscn").instance()
	box.add_child(list)
	addItem(list)
	list.init(txt,isNext)
	return list
	
func sel(arr,isNext = false):
	var list = load("res://tscn/eventDlg/eventSel.tscn").instance()
	box.add_child(list)
	list.init(arr,isNext)
	addItem(list)
	return list

func selBB(arr,isNext = false):
	var list = load("res://tscn/eventDlg/eventSel.tscn").instance()
	box.add_child(list)
	list.initBB(arr,isNext)
	addItem(list)
	return list
	
func buy(items):
	var list = load("res://tscn/eventDlg/eventBuy.tscn").instance()
	box.add_child(list)
	list.init(items)
	addItem(list)
	return list
	
func buyCha(items):
	var list = load("res://tscn/eventDlg/eventBuyCha.tscn").instance()
	box.add_child(list)
	list.init(items)
	addItem(list)
	return list
	
func check(per,mId = "",subVal = 1,stup = 0.2,tab = "",maxNum = 1):
	var list = load("res://tscn/eventDlg/eventCheck.tscn").instance()
	box.add_child(list)
	list.init(per,mId,stup,subVal,tab,maxNum)
	addItem(list)
	return list
	
func bat(team,canExit = true,faci = null):
	var list = load("res://tscn/eventDlg/eventBat.tscn").instance()
	box.add_child(list)
	list.init(team,canExit,faci)
	addItem(list)
	return list

func items(items):
	var list = load("res://tscn/eventDlg/eventItem.tscn").instance()
	box.add_child(list)
	list.init(items)
	addItem(list)
	return list
	
func selRelic(items):
	var list = load("res://tscn/eventDlg/eventRelic.tscn").instance()
	box.add_child(list)
	list.init(items)
	addItem(list)
	return list

func selSkill(skills):
	var list = load("res://tscn/eventDlg/eventSkill/eventSkill.tscn").instance()
	box.add_child(list)
	list.init(skills)
	addItem(list)
	return list
	
func itemSel(num,type = 0,isOnly = true):
	var list = load("res://tscn/eventDlg/eventItemSel/eventItemSel.tscn").instance()
	box.add_child(list)
	list.init(num,type,isOnly)
	addItem(list)
	return list
#显示一些物品（物品包：ItemPck）
func itemShow(items):
	var list = load("res://tscn/eventDlg/eventItemShow/eventItemShow.tscn").instance()
	box.add_child(list)
	list.init(items)
	addItem(list)
	return list
	
func selItem(items):
	var list = load("res://tscn/eventDlg/eventSelItem.tscn").instance()
	box.add_child(list)
	list.init(items)
	addItem(list)
	return list
	
func addItem(item):
	item.connect("onSel",self,"rSel")
	canShow()
var isClear = false
func del():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_scale", Vector2(1,0), 0.1).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self,"hide")
	if isClear :
		for i in box.get_children():
			i.queue_free()
		pass
	
func rHide():
	del()
	
func show():
	#rect_scale = Vector2(1,1)
	popup()
	rect_scale.y = 0.2
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	inx = 0
	if box.get_child_count() > 0 :
		box.get_child(inx).show()
	isClear = false
	
func clrar():
	isClear = true
	del()
	
func rSel(info):
	call_deferred("_rSel",info)
	
func _rSel(info):
	inx += 1
	if inx >= box.get_child_count() :
		isClear = true
		hide()
		return
	box.get_child(inx).show()
	var tween = create_tween()
	tween.tween_property($ScrollContainer,"scroll_vertical", int(box.get_child(inx).rect_position.y+1000), 0.3)
	
func canShow():
	if visible == false:
		show()
