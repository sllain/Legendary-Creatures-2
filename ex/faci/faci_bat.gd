extends Faci
class_name FaciBat
signal onBatEnd(isWin)

func _data():
	name = "普通敌人"
	dec = ""
	weight = 17
	num = 180
	tab = "world dungeon"
	dnum = 4
	batTime = 0.333
	xp = 6
	gold = 20
	repHp = 0.3

var bonusR = 1.0
var gold = 100
var powM  = 10
var powVal
var team := Team.new()
var xp = 6
var nowXp = 0
var origin = "城镇"  #出现哪些归属地的怪物
var batTime = 3 #战斗耗时

func _initInfo():
	if sys.game.mode == "map":
		if sys.game.isMainMap(): origin = "城镇"
		else: origin = "地牢"
	enemyInit(powM,lv)
func _trig():
	bat()
#敌方选角		
func enemyInit(powM,lv):
	team.chas.clear()
	powVal = initPow(powM)
	while powVal > 0 :
		var rcha = rnp.chaPool.rndItem(self,"rf")
		if rcha != null:
			addCha(data.newBase(rcha.id) )
			powVal -= 10
		else:
			powVal -= 1
#添加一个单位到队伍
func addCha(cha):			
	for i in lv - 1:
		cha.aiPlusLv()
	if cha.lv > 1 :
		var kn = int(cha.sp / cha.skills.items.size())
		var ys = int(cha.sp) % int(cha.skills.items.size())
		for i in cha.skills.items.size():
			var pn = kn + 1 if i < ys else kn
			cha.skills.items[i].lv += pn
			cha.sp -= pn
	if cha.lv > 1 :
		cha.addRndItem(cha.lv-1)
	team.addCha(cha)
	
#敌方排布			
func enemyLayout():
	var yl = [3,2,4,1,5,0,6]
	var mat = {}
	for cha in team.chas:
		for y in yl:
			var bl = false
			for x in range(5 - clamp(cha.ran,1,4),-1,-1)  :
				var cell = Vector2(x,y)
				if mat.has(cell) == false:
					cha.cell = cell
					mat[cell] = cha
					bl = true
					break
			if bl: break
#战斗流程	
var perfect = false
var canPerfect = true
func bat():
	var win = false
	if sys.player.lv > lv && canPerfect:
		sys.eventDlg.txt(tr("你的战力等级碾压了对面!"),true)
		win = true
		perfect = true
		countXp()
		recover()
	else:
		enemyLayout()
		if yield (sys.eventDlg.bat(team,true,self),"onSel") == 1 :
			enemyBuff()
			yield(sys.game,"onBattleEnd")
			batTxt()
			win = yield(sys.mapScene,"onBatSceneDel")
			recover()
		else:
			return
	countMiasma()
	countEnd(win)
	countDeath()
	emit_signal("onBatEnd")

func recover():
	for i in sys.player.team.chas:
		i.revive(false)
		i.plusHp((i.maxHp - i.hp) * repHp)
		
func countEnd(win):
	if win :
		var itemPck = ItemPck.new()
		bonus(itemPck)
		if itemPck.items.size() > 0 :
			sys.eventDlg.items(itemPck)
		del()
	else:
		sys.eventDlg.txt(tr("战败!"))
		
#敌方附加状态
func enemyBuff():
	pass
	
#经验加成
func countXp():
	nowXp = lvPer(lv,xp * bonusR,1)
	var per = 1.0
	if sys.game.isNight():
		per += 0.3
	nowXp = clamp(nowXp*per,0,99999)
func batTxt():
	var txt = ""
	if sys.batScene.isWin :
		sys.batScene.lv = lv  
		nowXp = lvPer(lv,xp * bonusR,1)
		txt = tr("基础魂： %d")% nowXp + "\n" 
		countXp()
		if sys.game.isNight():
			txt += tr("夜晚  +30%基础魂") + "\n"
		txt += tr("最终获得魂：%d") % nowXp
	else:
		txt = tr("战败") + "\n"
	sys.batScene.txt = txt
	
var repHp = 1.0
#瘴气推进
func countMiasma():
	var time = batTime
	if sys.game.diffLv >= 8 :time *= 1.5
	if sys.game.isMainMap() == false: time *= 0.5
	if sys.game.isTimeOn :
		sys.eventDlg.txt(tr("战斗消耗时间 %s，己方回复%d%%已损失生命值") % [sys.getTimeStr(time),repHp * 100],true)
		sys.game.nextTime(time)
	else:
		sys.eventDlg.txt(tr("己方回复%d%%已损失生命值") % [repHp * 100],true)

#死亡处理
func countDeath():
#	if sys.batScene.playDeathNum > 0 :
#		sys.eventDlg.txt("%d名角色战败，瘴气涨了%d层。" % [sys.batScene.playDeathNum,sys.batScene.playDeathNum])
#		sys.game.globals.g_m.lv += sys.batScene.playDeathNum
	pass
	
func initPow(powM):
	return lvPer(lv,powM,1.2)
#战斗奖励		
func bonus(itemPck:ItemPck):
	var item = data.newBase("m_gold")
	item.num = lvPer(lv,gold * bonusR)
	itemPck.addItem(item)
	item = data.newBase("m_xp")
	item.num = nowXp
	itemPck.addItem(item)

func rf(cha:Chara):
	if hasOrOri(cha.origin) == false:return false
	if cha.getPow() <= powVal :return true
	return false
	
#是否包含其中一个 出身地
func hasOrOri(tabs):
	for i in tabs.split(" "):
		for j in origin.split(" "):
			if i == j :
				return true
	return false
	
func getSave():
	var ds = {
		team = team.getSave(),
		bonusR = bonusR,
		powM = powM,
		origin = origin,
		canPerfect = canPerfect,
		gold = gold,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("bonusR",ds)
	dsSet("powM",ds)
	dsSet("origin",ds)
	dsSet("canPerfect",ds)
	dsSet("gold",ds)
	team = Team.new().setSave(ds.team)
