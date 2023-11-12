extends Base
class_name ItemPck

signal onAddItem(item,inx)
signal onDelItem(item,inx)
signal onFullItem(item)
signal onChangeItem(item)

var items :Array = []

func _init():
	pass
	
func clear():
	items.clear()

func addItem(item,inx = -1):
	if item.get("isNum") != null && item.isNum :
		var oi = hasIdedItem(item)
		if oi != null:
			oi.num += item.num
			#emit_signal("onAddItem",oi,inx)
			emit_signal("onChangeItem",oi)
			return
	if inx == -1 :inx = items.size()
	items.insert(inx,item)
	weight += 1
	emit_signal("onAddItem",item,inx)
	item.emit_signal("onEnter")
	emit_signal("onChangeItem",item)
	return item
	
func hasIdItem(id):
	for i in items :
		if i.id == id:
			return i
	return null
	
func hasIdedItem(item):
	for i in items :
		if i.id == item.id && i.lv == item.lv:
			return i
	return null
	
func delItem(item):
	var inx = items.find(item)
	if inx != -1:
		#items[inx] = null
		items.remove(inx)
		weight -= 1
		emit_signal("onDelItem",item,inx)
		item.emit_signal("onExit")
		emit_signal("onChangeItem",item)
		return inx
	
func delInxItem(inx):
	var item = items[inx]
	delItem(item)
	return item
	
func getSave():
	var itemL = []
	for i in items:
		if i == null:
			itemL.append(null)
		else:itemL.append(i.getSave())
	var ds = {
		items = itemL
	}
	return ds

func setSave(ds):
	for i in ds.items:
		if i != null :
			var item = data.newBase(i.id)
			item.setSave(i)
			addItem(item)
	return self

