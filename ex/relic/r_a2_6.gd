extends Relic

func _data():
	name = "随身暗器"
	lock = 0
	
func getDec():
	return tr("射手施放技能时，对最近2名敌方造成%d%%的物理伤害，触发攻击特效") % [lvPer(lv,50)]

func _in():
	sys.game.connect("onChaCastSkill",self,"r")

func r(skill):
	if skill.masCha.team == sys.player.team and skill.masCha.hasTab("射手"):
		var chas = skill.masCha.getMinRanChas(1,2)
		for i in chas:
			if i != null:
				skill.masCha.hurt(i,lvPer(lv,0.5) * skill.masCha.atk,HURTTYPE.PHY,ATKTYPE.NORMAL,self)
