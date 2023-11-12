extends Relic

func _data():
	name = "气势压制"
	lock = 0
	
func getDec():
	return tr("坦克提高%d%%的生命值，且他的技能会造成他%d%%最大生命值的额外魔法伤害") % [lvPer(lv,10),lvPer(lv,10)]

func _in():
	sys.game.connect("onChaInScene",self,"r")
	sys.game.connect("onChaCastHurt",self,"sk")
	
func r(cha):
	if cha.hasTab("坦克") == false :return
	var att = Att.new()
	cha.addAtt(att)
	perAdd("maxHp",lvPer(lv,0.1))

func sk(atkInfo):
	if atkInfo.castCha.team == sys.player.team and atkInfo.atkType == ATKTYPE.SKILL and atkInfo.castCha.hasTab("坦克"):
		atkInfo.castCha.hurt(atkInfo.cha,atkInfo.castCha.maxHp*lvPer(lv,0.1),HURTTYPE.MAG,ATKTYPE.EFF,self)
