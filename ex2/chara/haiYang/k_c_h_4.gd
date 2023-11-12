extends Skill

func _data():
	name = "水隐刀"
	cd = 0
	tab = "专属"

func getDec():
	return tr("开战时闪现至血量最低的敌人旁，获得%d层隐身，隐身期间普攻附加%d%%物理攻击的真实伤害") % [per(15),per(60)]

func _in():
	sys.game.connect("onBattleStart",self,"r")
	masCha.connect("onCastHurt",self,"r3")
	
func r():
	var cell = masCha.cell
	if masCha.team == sys.player.team :
		cell.x = 9
	else:
		cell.x = 0
	masCha.matMoveUp(cell)
	masCha.aiCha = null
	masCha.castBuff(masCha,"b_a_yinShen",per(15))
	
func r3(atkInfo):
	if masCha.yingTime > 0 && atkInfo.atkType == ATKTYPE.NORMAL:
		hurt(atkInfo.cha,masCha.atk * per(0.6),HURTTYPE.REAL,ATKTYPE.EFF)

