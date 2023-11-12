extends Skill

func _data():
	name = "质能坍缩"
	cd = 12
	tab = "专属"

func getDec():
	return tr("投掷质能球对目标造成%d%%的魔法伤害附加%d层随机负面状态，如果目标有%d层以上负面状态则分裂成2个追击最近的敌方，最多分裂%d次") % [per(35),per(8),fn,4]

func _cast():
	mas.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	d(masCha,masCha.aiCha,4)
	
const bbfs2 = ["b_b_liuXue","b_b_zhongDu","b_b_shaoZhuo","b_b_jieShuang","b_b_poJia","b_b_maBi"]

var fn = 20
	
func d(ocha,cha,n):
	if n <= 0 || cha == null || ocha == null:return
	var eff:Eff = sys.batScene.newEff("e_atk1",ocha.position,ocha.imgCenterPos)
	eff.get_node("up/img").frame = 5
	eff.flyToChara(cha,300)
	eff.get_node("up").scale = Vector2(n,n)
	n -= 1
	yield(eff,"onReach")
	eff.queue_free()
	hurtPerM(cha,per(0.35))
	masCha.castBuff(cha,rndListItem(bbfs2),per(8))
	var p = 0
	for i in cha.affs:
		if i is Buff && i.hasTab("deBuff") && i.lv > 0:
			p += i.lv
	if n > 1 && p >= fn:
		var cs = cha.getMinRanChas(2,2)
		for i in cs :
			if i != null:
				d(cha,i,n)

