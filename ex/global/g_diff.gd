extends Global

var lvDec = {
	0:tr("初始难度，小试身手"),
	1:tr("敌人的属性小幅增加"),
	2:tr("瘴气对敌人属性的影响提高100%"),
	3:tr("夜晚的敌人获得15%的增伤和减伤"),
	4:tr("大地图移动1格消耗的时间增加10分钟"),
	5:tr("敌人的属性中幅增加"),
	6:tr("魔王战敌人获得魔王军状态 %d%%的增伤和减伤") % [20],
	7:tr("瘴气对敌人属性的影响提高200%"),
	8:tr("战斗的时间花费增加50%"),
	9:tr("敌人的属性大幅增加"),
	10:tr("魔王觉醒并诅咒你的部队，减少%d%%的增伤和减伤") % 10,
	11:tr("瘴气层数无上限"),
	12:tr("敌人的属性超幅增加"),
#	13:tr("魔王变的更强"),
#	14:tr("夜晚的敌人获得30%的增伤"),
#	15:tr("魔王觉醒，他的仆从参战"),
}

func _data():
	name = "难度"
	txt = tr("难度")
	excMode = "tower"

func _in():
	lv = sys.game.diffLv
	if lv >= 1 : sys.game.connect("onBattleReady",self,"_bat")
	if lv >= 4 :
		sys.game.timeNext += 0.1666
	if lv >= 7 :
		sys.game.globals.g_m.mp *= 3
	elif lv >= 2 :
		sys.game.globals.g_m.mp *= 2
	sys.game.connect("onChaHurtStart",self,"_hurt")
	if lv >= 11:
		sys.game.globals.g_m.maxMlv = 999

func _bat():
	for i in sys.batScene.getAllChas():
		if i.team != sys.player.team :
			var att = Att.new()
			i.addAtt(att)
			var p = 0.1
			if lv >= 12 :
				p = 0.9
			elif lv >= 9 :
				p = 0.6
			elif lv >= 5:
				p = 0.3
			att.perMul("def",p)
			att.perMul("mdef",p)
			att.perMul("atk",p)
			att.perMul("matk",p)
			att.perMul("maxHp",p)	

func _hurt(atkInfo):
	if lv == 0 :
		if atkInfo.castCha.team == sys.player.team :
			atkInfo.finalPer += 0.10
		if atkInfo.cha.team == sys.player.team:
			atkInfo.finalPer -= 0.10
	if lv >= 3 && sys.game.isNight() :
		if atkInfo.castCha.team != sys.player.team :
			atkInfo.finalPer += 0.15
		if atkInfo.cha.team != sys.player.team:
			atkInfo.finalPer -= 0.15
	if lv >= 10 :
		if atkInfo.castCha.team == sys.player.team :
			atkInfo.finalPer -= 0.10
		if atkInfo.cha.team == sys.player.team:
			atkInfo.finalPer += 0.10
