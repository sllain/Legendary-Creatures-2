extends Skill

func _data():
	name = "斩杀"
	cd = 0
	tab = "专属"

func getDec():
	return tr("任意伤害秒杀生命值低于%d%%的敌人，并闪现至另一个血量最低敌方旁") % per(20)

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType != ATKTYPE.EFF && atkInfo.cha.hp / atkInfo.cha.maxHp <= per(0.20):
		hurt(atkInfo.cha,999999,HURTTYPE.REAL,ATKTYPE.EFF)
		var cha = masCha.getMinHpCha(1)
		if cha != null:
			var cell = cha.cell
			masCha.matMoveUp(cell)
			masCha.aiCha = null
