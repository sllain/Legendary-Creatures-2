extends GemUn

func _data():
	name = "抵技石"
	tab = "坦克 辅助"
	isUnique = true
	
func _in():
	masCha.connect("onHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL && cds <= 0:
		atkInfo.val = 0
		cds = 10 - lv

func getDec():
	return tr("开战时和每%d秒抵消一次技能伤害") % [10-lv]

var cds = 0
func upS():
	if cds > 0 :
		cds -= 1
