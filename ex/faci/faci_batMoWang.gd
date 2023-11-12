extends FaciBatBoss

func _data():
	name = "魔王"
	dec = "打败魔王游戏就获得胜利！"
	weight = 1
	tab = "world"
	powM = 30
	lock = -1
	self.visible = true
	self.glow = true
	bossBuffLv = 3
	canPerfect = false
		
func bonus(itemPck:ItemPck):
	var item = data.newBase("m_cry")
	item.num = lvPer(lv,5,0.3) * lvPer(sys.game.diffLv,1,0.1)
	itemPck.addItem(item)
	
func countEnd(win):
	if win:
		sys.game.end(win)
	
func countDeath():
	pass
	
func countMiasma():
	pass
	
func enemyInit(powM,lv):
	team.chas.clear()
	powVal = initPow(powM)
	var cha = data.newBase("c_m_1") 
	addCha(cha)
	while powVal > 0 :
		var rcha = rnp.chaPool.rndItem(self,"rf")
		if rcha != null:
			addCha(data.newBase(rcha.id) )
			powVal -= 10
		else:
			powVal -= 1
	initBoss()
		
func _in():
	sys.mapScene.upCell(cell)
	
func initBoss():
	var cha:Chara = team.chas[0]
	cha.isBoss = true
	cha.addRndItem(clamp(cha.lv-1,1,5))
	cha.addRndItem(clamp(cha.lv-1,1,5))

func enemyBuff():
	.enemyBuff()
	if sys.game.diffLv < 6 :return
	for i in team.chas:
		i.castBuff(i,"b_a_moJun",1)
