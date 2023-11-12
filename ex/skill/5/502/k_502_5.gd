extends Skill

func _data():
	name = "火焰附魔"
	cd = 0
	tab = "火法"
	
func getDec():
	return tr("战斗开始时，为自己和攻速最快的友军附魔，使其普攻额外造成%d%%魔法伤害，%d%%的几率附加%d层烧灼") % [per(0.4) * 100,30,per(5)]

var fcha = null
func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	fcha = masCha.getMaxAttCha("spd",2)
	if fcha != null:
		masCha.castBuff(fcha,"b_k_zy_huo_5",lv)
	masCha.castBuff(masCha,"b_k_zy_huo_5",lv)
