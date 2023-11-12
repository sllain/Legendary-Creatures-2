extends Relic

func _data():
	name = "藏品"
	lock = 0
	
func getDec():
	return tr("开启宝箱时，额外获取%d个等同于宝箱等级的随机普通消耗品") % [lvPer(lv,1)]

func _in():
	sys.game.connect("onTrigFaci",self,"r")
	
func r(faci,id,info):
	if id == "boxOpen":
		for i in lvPer(lv,1):
			var item = data.newBase(rnp.csbPool.rndItem().id)
			item.lv = faci.lv
			info.addItem(item)
		
