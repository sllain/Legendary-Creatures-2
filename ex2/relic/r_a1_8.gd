extends Relic

var step = 0


func _data():
	name = "断剑"
	lock = 0
	
func getDec():
	return tr("战士每3次普通攻击时，必定暴击，并回复%d%%攻击力的生命") % [lvPer(lv,40)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.castCha.hasTab("战士") and atkInfo.atkType == ATKTYPE.NORMAL :
		step += 1
		if step == 3:
			step = 0
			atkInfo.isCri = true
			atkInfo.castCha.plusHp(atkInfo.castCha.atk*lvPer(lv,0.4))
