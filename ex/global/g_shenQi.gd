extends Global

func _data():
	name = "浩劫"
	txt = ""
	dec = "大地图上的所有的常规战斗事件提升1级,包括魔王！"
	isVisIco = false
	lv = 0
	excMode = "tower"

var can = false
var on = false

func _in():
	sys.game.connect("onToMap",self,"_toMap")
	sys.game.connect("onNextTime",self,"_nextTime")
	
func _toMap(id):
	haoJie()
		
func _nextTime():
	haoJie()
	
func start():
	self.isVisIco = true
	self.can = true
		
func haoJie():
	if on == false && can && sys.game.isMainMap():
		on = true
#		self.dec = "最后的审判来临，瘴气弥漫大地，魔王觉醒！大地图上的所有的常规战斗事件提升1级,包括魔王"
#		sys.newMsg(dec)
		for i in sys.mapScene.objs.items:
			if i is FaciBat :
				i.lv += 1
				for cha in i.team.chas:
					cha.aiPlusLv()
					for eqp in cha.eqps.items:
						if eqp != null:
							eqp.lv += 1
							eqp.plusGemUnique(eqp.lv)
							
func getSave():
	var ds = {
		can = can,
		on = on,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("can",ds)
	dsSet("on",ds)
