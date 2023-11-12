extends Skill

var dmg = 0

func _data():
	name = "圣盾术"
	cd = 6
	tab = "圣骑士"
	
func getDec():
	return tr("使自身和最虚弱友军获得%d%%圣骑士最大生命值的护盾，10层抵御") %  [per(15)]

func _cast():
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	masCha.plusWard(masCha.maxHp * per(0.15),masCha)
	masCha.castBuff(masCha,"b_a_diYu",10)
	var cha = masCha.getWeakCha(2)
	if cha != null:
		masCha.plusWard(masCha.maxHp * per(0.15),cha)
		masCha.castBuff(cha,"b_a_diYu",10)
