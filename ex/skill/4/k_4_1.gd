extends Skill

func _data():
	name = "闪影割喉"
	cd = 10
	tab = "刺客"

func getDec():
	return tr("闪现敌方后排，对最近单位造成%d%%的物理伤害，开战时满cd") % per(200)

var b = false
func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	cdVal = cd
	b = false
	pass
	
func _cast():
	if b == false:
		var cell = masCha.cell
		if masCha.team == sys.player.team :
			cell.x = 9
		else:
			cell.x = 0
		masCha.matMoveUp(cell)
		b = true
		masCha.aiCha = null
	mas.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.2),"timeout")
	if masCha.aiCha != null:
		var eff = mas.scene.newEff("e_shanYingGeHou",masCha.aiCha.position, mas.imgCenterPos)
		hurtPer(masCha.aiCha,per(2.0))
		
