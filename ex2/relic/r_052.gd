extends Relic

func _data():
	name = "破陨之心"
	
func getDec():
	return tr("对方的战力等级每高于我方一级，我方增伤和减伤提高%d%%") % [lvPer(lv,15)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"dmg")
#	sys.game.connect("onChaHurtStart",self,"hurt")

func dmg(atkInfo):
	if sys.batScene.faci.lv > sys.game.player.lv and atkInfo.castCha != null:
		#增伤
		#0.2 * (sys.batScene.faci.lv-sys.game.player.lv)
		#print(per(20) * (sys.batScene.faci.lv-sys.game.player.lv))
		if atkInfo.castCha.team == sys.player.team:
			atkInfo.per += lvPer(lv,0.15) * (sys.batScene.faci.lv-sys.game.player.lv)
		#减伤
		else:
			atkInfo.per -= lvPer(lv,0.15) * (sys.batScene.faci.lv-sys.game.player.lv)
