extends Skill

func _data():
	name = "影风车"
	cd = 8
	tab = "忍者"

func getDec():
	return tr("投掷一枚手里剑造成%d%%的物理伤害，可以暴击，暴击时可弹射至最近敌方，最多弹射10次") % (per(140))

var n = 0
func _cast():
	n = 10
	mas.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	d(masCha,masCha.aiCha)
	
func d(ocha,cha):
	if n <= 0 || cha == null || ocha == null:return
	var eff:Eff = mas.scene.newEff("e_feiBiao",ocha.position, Vector2(0, -20))
	eff.flyToChara(cha,500)
	n -= 1
	yield(eff,"onReach")
	var atkInfo = masCha.newAtkInfo(cha,masCha.atk * per(1.4),HURTTYPE.PHY,ATKTYPE.SKILL,self)
	atkInfo.canCri = true
	if masCha.hurtBase(atkInfo).isCri :
		d(cha,cha.getMinRanCha(2))

