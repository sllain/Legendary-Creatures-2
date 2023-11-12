extends Skill

func _data():
	name = "雷霆震击"
	cd = 7
	tab = "机关人"
	
func getDec():
	return tr("对周围1格造成自身%d%%的物理伤害，附加%d层麻痹和%d层眩晕") %  [per(1.8)*100,per(15),per(5)]

func _cast():
	
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	var chas = sys.batScene.getCellChas(masCha.cell,1)
	if chas.size() == 0:return
	var eff = mas.scene.newEff("e_leiZhen",masCha.position,masCha.imgCenterPos)
	for i in chas:
		if i == null : continue
		if i.team == masCha.team : continue
		hurtPerP(i,per(1.8))
		masCha.castBuff(i,"b_b_maBi",per(15))
		masCha.castBuff(i,"b_b_xuanYun",per(5))

