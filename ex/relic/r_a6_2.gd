extends Relic

func _data():
	name = "鼓舞之威"
	
func getDec():
	return tr("辅助施放技能时，最近一名友军获得%d层狂怒和威能") % [lvPer(lv,8)]

func _in():
	sys.game.connect("onChaCastSkill",self,"r")

func r(skill):
	if skill.masCha.team == sys.player.team && skill.masCha.hasTab("辅助"):
		var cha = skill.masCha.getMinRanCha(2)
		if cha == null :return
		skill.masCha.castBuff(cha,"b_a_kuangNu",lvPer(lv,8))
		skill.masCha.castBuff(cha,"b_a_weiNeng",lvPer(lv,8))
