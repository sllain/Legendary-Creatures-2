extends Skill

func _data():
	name = "机械臂爪"
	cd = 10
	tab = "机关人"
	
func getDec():
	return tr("把距离最远的单位拉至身边造成%d%%物理伤害并附加%d层麻痹，开场满CD") %  [per(200),per(25)]

func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	cdVal = cd


func _cast():
	mas.playAnim("atk")
	yield(ctime(0.3),"timeout")
	var cha = masCha.getMaxRanCha()
	if cha != null:
		var eff = mas.scene.newEff("e_fenSui",cha.position, cha.imgCenterPos)
		cha.matMoveUp(masCha.cell)
		hurtPerP(cha,per(2.0))
		masCha.castBuff(masCha.aiCha,"b_b_maBi",per(25))
		cha.aiCha = null
		masCha.aiCha = null

