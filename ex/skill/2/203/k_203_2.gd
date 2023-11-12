extends Skill

func _data():
	name = "爆破榴弹"
	cd = 8
	tab = "火枪手"

func getDec():
	return tr("对目标及1格内单位造成%d%%的物理伤害，附加%d层烧灼和破甲,视为普攻") % [per(1.2)*100,per(10)]

func _cast():
	if masCha.aiCha == null :return
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
# 	var eff:Eff = mas.scene.newEff("e_huoQiu",mas.position,mas.imgCenterPos)
# 	eff.modulate = Color("#e74d09")
# 	eff.flyToChara(masCha.aiCha, 450)
# 	eff.connect("onReach",self,"r")
	
# func r():
	var baoZhaEff = mas.scene.newEff("e_baoZha1",masCha.aiCha.position,masCha.aiCha.imgCenterPos)
	yield(ctime(0.1),"timeout")
	var chas = sys.batScene.getCellChas(masCha.aiCha.cell,1)
	for i in chas:
		if i == null : continue
		if i.team == masCha.team :continue
		hurtPerP(i,per(1.2),ATKTYPE.NORMAL)
		masCha.castBuff(i,"b_b_poJia",per(10))
		masCha.castBuff(i,"b_b_shaoZhuo",per(10))
