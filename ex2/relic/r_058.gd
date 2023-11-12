extends Relic

var step = 0

func _data():
	name = "能量转换"
	
func getDec():
	return tr("我方的普通攻击能偷取目标%d%%的护盾值") % [lvPer(lv,30)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")
	

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team and atkInfo.atkType == ATKTYPE.NORMAL :
		if atkInfo.cha.ward > 0:
			var val = atkInfo.cha.ward*lvPer(lv,0.3)
			atkInfo.castCha.plusWard(val,atkInfo.castCha)
			atkInfo.cha.ward -= val
