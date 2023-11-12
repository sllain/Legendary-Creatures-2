extends Relic

var step = 0

func _data():
	name = "狂欢"
	
func getDec():
	return tr("生命值高于70%%的单位，获得%d%%的增伤和减伤") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"dmg")
	sys.game.connect("onChaHurtStart",self,"getHurt")

func dmg(atkInfo):
	if atkInfo.castCha.team == sys.player.team and atkInfo.castCha.hp/atkInfo.castCha.maxHp >= 0.7:
		atkInfo.per += lvPer(lv,0.1)

func getHurt(atkInfo):
	if atkInfo.cha.team == sys.player.team and atkInfo.cha.hp/atkInfo.cha.maxHp >= 0.7:
		atkInfo.per -= lvPer(lv,0.1)
