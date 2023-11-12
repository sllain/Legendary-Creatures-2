extends GemUn

func _data():
	name = "巨力石"
	tab = "战士"
	isUnique = true
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
			if i.team != mas.team && i != masCha.aiCha:
				hurtPer(i,per(0.3),ATKTYPE.EFF)
	
func getDec():
	return tr("普通攻击对1格内其他敌人造成%d%%的物理伤害") % [per(30)]
	
