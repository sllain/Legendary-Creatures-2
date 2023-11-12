extends Skill

func _data():
	name = "霜之刃"
	cd = 0
	tab = "专属"

func _in():
	masCha.connect("onNormAtk",self,"r1")
	masCha.connect("onCastSkill",self,"r2")
	pass
	
func r1():
	qiu()
	
func r2(skill):
	qiu(2)
		
func getDec():
	return tr("普攻%d%%的几率召唤1枚冰球对最近敌方造成%d%%的魔法伤害附加%d层结霜。而施放技能时召唤%d枚同样的冰球") % [60,per(70),per(10),2]

func qiu(n = 1):
	for i in n:
		if masCha.aiCha != null:
			var cha = masCha.aiCha
			var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
			eff.get_node("up/img").frame = 4
			eff.flyToChara(cha,300)
			eff.connect("onReach",self,"qiuR",[cha])
			yield(ctime(0.2),"timeout")

func qiuR(cha):
	hurtPer(cha,per(0.7),HURTTYPE.MAG)
	masCha.castBuff(cha,"b_b_jieShuang",per(10))
