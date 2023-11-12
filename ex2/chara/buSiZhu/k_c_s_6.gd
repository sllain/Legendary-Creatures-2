extends Skill

func _data():
	name = "招魂术"
	cd = 0
	tab = "专属"
func getDec():
	return tr("复活第一个死亡的非召唤友方单位，恢复%d%%生命值，并使其获得%d层隐身") %  [per(0.5) * 100,10]

func _in():
	sys.game.connect("onBattleStart",self,"r")
	sys.game.connect("onChaDeathStart",self,"rD")
	
func r():
	b = true
	
var b = false
func rD(atkInfo):
	if atkInfo.cha.team == sys.player.team && atkInfo.cha.isSummon == false && b && atkInfo.cha.isDeath:
		atkInfo.cha.revive(false)
		masCha.plusHp(atkInfo.cha.maxHp * per(0.5),atkInfo.cha)
		b = false
		masCha.castBuff(atkInfo.cha,"b_a_yinShen",10)
