extends Relic

var p = 0

func _data():
	name = "职责分明"
	
func getDec():
	return tr("战斗开始时，队伍每有一个不重复的主职业角色，全队增伤和减伤提高%d%%") % [lvPer(lv,3)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"dmg")
	sys.game.connect("onChaHurtStart",self,"getHurt")
	sys.game.connect("onBattleStart",self,"reset")
	
func reset():
	var p = 0
	var fn = []
	for i in sys.batScene.getAllChas() :
		if i.team == sys.player.team :
			var o = i.getOrientation()
			if fn.has(o) == false :
				fn.append(o)
				p += 0.03
	
func dmg(atkInfo):
	if atkInfo.castCha.team == sys.player.team :
		atkInfo.per += per(p)

func getHurt(atkInfo):
	if atkInfo.cha.team == sys.player.team :
		atkInfo.per -= per(p)
	

