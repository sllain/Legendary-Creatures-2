extends Skill

func _data():
	name = "蟹甲"
	cd = 0
	tab = "专属"
func getDec():
	return tr("每2秒获得%d层抵御，受到技能伤害时，会消耗自身%d层抵御来抵消一次伤害") %  [per(5),bn]

func _in():
	masCha.connect("onHurtStart",self,"r")

var pn = 0
var bn = 10

func r(atkInfo):
	var buff = masCha.hasAff("b_a_diYu")
	if buff == null:return
	if atkInfo.atkType == ATKTYPE.SKILL && buff.lv >= bn:
		buff.lv -= bn
		atkInfo.val = 0
			
func _upS():
	pn += 1
	if pn >= 2 :
		masCha.castBuff(masCha,"b_a_diYu",per(5))
		pn = 0

