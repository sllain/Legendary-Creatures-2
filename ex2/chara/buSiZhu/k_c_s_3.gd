extends Skill

func _data():
	name = "尸骸重组"
	cd = 0
	tab = "专属"
func getDec():
	return tr("死亡时复活1次，恢复%d%%生命值，获得%d%%最大生命值的护盾，获得%d层抵御") %  [per(0.5) * 100,per(0.5) * 100,per(30)]

func _in():
	sys.game.connect("onBattleStart",self,"r")
	masCha.connect("onDeathStart",self,"rD")
	
func r():
	b = true
	
var b = false
func rD(atkInfo):
	if b && masCha.isDeath:
		masCha.revive(false)
		plusHp(masCha.maxHp * per(0.5))
		plusWard(masCha.maxHp * per(0.5))
		b = false
		masCha.castBuff(masCha,"b_a_diYu",per(30))
