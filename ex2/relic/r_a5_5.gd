extends Relic

func _data():
	name = "湮灭禁术"
	
func getDec():
	return tr("法师施放技能时，对生命值最低的敌方造成%d%%法强的魔法伤害") % [lvPer(lv,80)]

func _in():
	sys.game.connect("onChaCastSkill",self,"r")

func r(skill):
	if skill.masCha != sys.player.team and not skill.masCha.hasTab("法师"):return
	var cha = skill.masCha.getWeakCha(1)
	if cha != null:
		skill.masCha.hurt(cha,lvPer(lv,0.8)*skill.masCha.matk,HURTTYPE.MAG,ATKTYPE.SKILL,self)

