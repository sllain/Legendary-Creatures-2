extends Relic

func _data():
	name = "熟能生巧"
	
func getDec():
	return tr("法师角色掌握的第二个技能，在施放时有%d%%的概率重复施放一次") % [lvPer(lv,15)]

func _in():
	sys.game.connect("onChaCastSkill",self,"r")

func r(skill):
	if skill.masCha != sys.player.team and not skill.masCha.hasTab("法师"):return
	if skill.masCha.skills.items.size() >= 1:return
	if skill == skill.masCha.skills.items[1]:
		if skill.cd != 0 and sys.rndPer(lvPer(lv,0.15)): 
			skill._cast()
			pass
