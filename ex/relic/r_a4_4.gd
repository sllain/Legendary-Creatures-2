extends Relic

func _data():
	name = "心狠手辣"
	
func getDec():
	return tr("刺客获得%d%%的暴击率，暴击时获得%d层狂怒") % [lvPer(lv,10),lvPer(lv,5)]


func _in():
	sys.game.connect("onChaInScene",self,"r")
	sys.game.connect("onChaCastHurt",self,"r2")
	
func r(cha):
	if cha.team != sys.player.team :return
	if cha.hasTab("刺客") == false:return
	var att = Att.new()
	cha.addAtt(att)
	att.cri = 0.1 * lv
	
func r2(atkInfo):
	if atkInfo.castCha.team == sys.player.team and atkInfo.castCha.hasTab("刺客"):
		if atkInfo.isCri:
			atkInfo.castCha.castBuff(atkInfo.castCha,"b_a_kuangNu",lvPer(lv,5))
