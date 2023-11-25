extends Skill

func _data():
	name = "打造"
	cd = 0
	tab = "专属"
	lock = -1
	
func getDec():
	return tr("将身上3个相同等级的装备合成为高一级的装备,1级装备无法合成，每合成一个装备永久获得 %d * 装备等级 的物理攻击") % [per(5)]

func _in():
	masCha.eqps.connect("onAddItem",self,"_addItem")
	atk = plAtk
	
func _addItem(item,inx):
	var eqps = masCha.eqps
	for i in eqps.items:
		if i == null:return
		if i.lv <= 1 :return
	if eqps.items[0].lv != eqps.items[1].lv || eqps.items[1].lv != eqps.items[2].lv :
		return
	var ii = eqps.items[0]
	eqps.clear()
	eqpSelDlg(ii.lv + 1)
	plAtk += (ii.lv + 1) * per(5)
	self.atk = plAtk

#获取装备对话框
func eqpSelDlg(lv = 1):
	eqpLv = lv
	sys.eventDlg.selItem(eqpSelGet()).reUpBtn.link(10,self,"eqpSelGet")
var eqpLv = 1
var rs
func eqpSelGet():
	rs = []
	for i in 3 :
		var rv = data.newBase(rnp.eqpPool.rndItem(self,"rndItemSelDlg").id) 
		rv.create(eqpLv)
		rs.append(rv)
	return rs

func rndItemSelDlg(item):
	for i in rs :
		if i.id == item.id :return false
	return true

var plAtk = 0

func getSave():
	var ds = {
		plAtk = plAtk,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("plAtk",ds)
