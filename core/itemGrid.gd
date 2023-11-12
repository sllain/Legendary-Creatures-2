extends Base
class_name ItemGrid

signal onAddItem(item,inx)
signal onDelItem(item,inx)
signal onFullItem(item)
signal onChangeItem(pck,inx1,inx2)
signal onUp(inx,oldItem,newItem)

var items :Array = []
var maxItem = 0

func _init(maxItem = 0):
	self.maxItem = maxItem
	for i in range(maxItem):
		items.append(null)
#	connect("onAddItem",self,"rAddItem")
#	connect("onDelItem",self,"rDelItem")
#
#func rAddItem(item,inx):
#	if item != null:
#		item.pck = self
#func rDelItem(item,inx):
#	if item != null:
#		item.pck = null

func clear():
	for i in items:
		delItem(i)

func addItem(item,inx = 0):
	if items.size() > 0:
		if items[inx] == null:
			items[inx] = item
			emit_signal("onAddItem",item,inx)
			up(inx,null,item)
			return true
		else:
			for i in range(maxItem):
				if items[i] ==  null:
					items[i] = item
					item.inx = i
					emit_signal("onAddItem",item,i)
					up(i,null,item)
					return true
					break
			emit_signal("onFullItem",item)
	return false
	
func delItem(item):
	var inx = items.find(item)
	if inx != -1:
		items[inx] = null
		emit_signal("onDelItem",item,inx)
		up(inx,item,null)
		return inx
	
func delInxItem(inx):
	var item = items[inx]
	delItem(item)
	return item
	 
func changeItem(pck:ItemPck,inx1,inx2):
	var i1 = pck.items[inx1]
	var i2 = items[inx2]
	pck.items[inx1] = i2
	items[inx2] = i1
	if i1 != null:
		i1.inx = inx2
		if pck != self :
			pck.emit_signal("onDelItem",i1,inx1)
			emit_signal("onAddItem",i1,inx2)
	if i2 != null:
		i2.inx = inx1
		if pck != self :
			emit_signal("onDelItem",i2,inx1)
			pck.emit_signal("onAddItem",i2,inx2)
	emit_signal("onChangeItem",pck,inx1,inx2)
	pck.up(inx1,i1,i2)
	up(inx2,i2,i1)
	
func up(inx,oldItem,newItem):
	emit_signal("onUp",inx,oldItem,newItem)
	
func getSave():
	var itemL = []
	for i in items:
		if i == null:
			itemL.append(null)
		else:itemL.append(i.getSave())
	var ds = {
		maxItem = maxItem,
		items = itemL
	}
	return ds

func setSave(ds):
	_init(ds.maxItem)
	for i in ds.items:
		if i != null :
			var item = data.newBase(i.id)
			item.setSave(i)
			addItem(item)
	return self
