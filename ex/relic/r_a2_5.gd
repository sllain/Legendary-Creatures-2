extends Relic

func _data():
	name = "备用箭矢"
	
func getDec():
	return tr("射手普攻%d%%的概率，对另一名敌人造成%d%%的物理伤害，触发攻击特效") % [lvPer(lv,40),lvPer(lv,40)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team and atkInfo.atkType == ATKTYPE.NORMAL and atkInfo.castCha.hasTab("射手"):
		if sys.rndPer(lvPer(lv,0.4)):
			var chas = sys.batScene.getAllChas()
			for i in chas:
				if i == null or i.team == atkInfo.castCha.team or i == atkInfo.castCha:
					chas.erase(i)
			if chas.size() > 0:
				var cha = sys.rndListItem(chas)
				atkInfo.castCha.hurt(cha,lvPer(lv,0.4) * atkInfo.castCha.atk,HURTTYPE.PHY,ATKTYPE.EFF,self)
				
