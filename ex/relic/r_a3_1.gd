extends Relic

func _data():
	name = "临危不乱"
	
func getDec():
	return tr("坦克释放技能时回复自身最大生命值%d%%的生命") % [lvPer(lv,6)]

func _in():
	sys.game.connect("onChaCastSkill",self,"r")

func r(skill):
	if skill.masCha.team == sys.player.team && skill.masCha.hasTab("坦克"):
		skill.masCha.plusHp(skill.masCha.maxHp * lvPer(lv,0.06))
