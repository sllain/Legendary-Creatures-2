extends Eqp

func _data():
	name = "水光刃"
	isOnly = true
	var ds = {
		atk = 4,
		pen = 1,
	}
	attRatio(ds)
	lv = 5
	tab = "谜团"
	
	dec = tr("本场战斗每击杀一个单位 +%d的穿透") % [15]
	self.pen = 0

func _in():
	masCha.connect("onKill",self,"r")
	self.pen = 0
	
func r(atkInfo):
	self.pen += per(15)
	
