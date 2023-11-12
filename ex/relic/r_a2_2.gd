extends Relic

func _data():
	name = "技术射击"
	
func getDec():
	return tr("射手施放技能后，获得%d层急速") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onChaCastSkill",self,"r")

func r(skill):
	if skill.masCha.team == sys.player.team && skill.masCha.hasTab("射手"):
		skill.masCha.castBuff(skill.masCha,"b_a_jiSu",lvPer(lv,10))
