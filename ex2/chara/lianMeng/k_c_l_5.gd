extends Skill

func _data():
	name = "雷罚净世"
	cd = 8
	tab = "专属"
var enchant = false

func getDec():
	return tr("对目标造成%d%%的魔法伤害，附加10层麻痹，并使下一个技能伤害提升%d%%") %  [per(1.3)*100,per(0.5)*100]

func _cast():
	if masCha.aiCha == null:return
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	var eff = mas.scene.newEff("e_leiFaJiangShi",masCha.aiCha.position, masCha.aiCha.imgCenterPos)
	eff.scale = Vector2(0.5,0.75)
	yield(ctime(0.2),"timeout")
	hurtPerM(masCha.aiCha,per(1.3))
	masCha.castBuff(masCha.aiCha,"b_b_maBi",10)
	reset(true)

func _in():
	sys.game.connect("onBattleStart",self,"reset")
	masCha.connect("onCastHurt",self,"r")
	
func reset(bl=false):
	enchant = bl
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL and enchant == true:
		atkInfo.per += per(0.5)
		enchant = false 
	
			
