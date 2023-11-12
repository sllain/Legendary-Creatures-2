extends Skill

func _data():
	name = "攻其不备"
	cd = 10
	tab = "专属"

func getDec():
	return tr("闪现至血量最低的敌人旁，造成%d%%的物理伤害，获得%d层隐身，且每5层隐身使该伤害提高%d%%") % [per(200),8,20]

func _cast():
	mas.playAnim("atk2")
	yield(ctime(0.2),"timeout")
	masCha.aiCha = null
	var bf = masCha.castBuff(masCha,"b_a_yinShen",8)
	var p = 1.0
	if bf != null && bf.lv > 0 : p = lv * 0.2 * 0.2
	var cha = masCha.getMinHpCha()
	if cha == null: return
	masCha.matMoveUp(cha.cell)
	hurtPerP(cha,per(200) * p)
	
	
