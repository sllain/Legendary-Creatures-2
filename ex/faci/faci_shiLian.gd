extends FaciBat

func _data():
	name = "竞技场"
	dec = "挑战各路豪杰，获得更高奖励。"
	weight = 0.5
	num = 3
	tab = "world"
	isCs = true
	canPerfect = false
	
var items = ItemPck.new()
var nowItems = ItemPck.new()

const nums = [2,3,4]
	
func _createStart():
	createLv = nums[0]
	nums.remove(0)
	if sys.isDemo :
		origin = "城镇"
	else:origin = "驱魔联盟"
	
var win = false
	
func _trig():
	sys.eventDlg.txt(tr("将经历数次战斗，每次胜利都能积累战利品，失败将一无所获，做好准备了吗？"),true)
	if yield(sys.eventDlg.sel([tr("接受挑战"),tr("离开")]),"onSel") == 1 :return
	del()
	for i in 5 :
		nowItems.clear()
		nowItems.addItem(data.newBase("m_gold").setNum(lvPer(lv,50)))
		nowItems.addItem(data.newBase("m_xp").setNum(lvPer(lv,20)))
		if i > 1 :
			var item = data.newBase(rnp.eqpPool.rndItem().id)
			item.create(clamp(i,1,4))
			nowItems.addItem(item)
		sys.eventDlg.itemShow(nowItems).lab.text = "本次的战利品"
		var inx = yield(sys.eventDlg.selBB([tr("挑战，失败的话累积的战利品清空"),tr("放弃，并领取积累的战利品")]),"onSel")
		if inx == 0 :
			enemyInit(lvPer(i+1,10,0.7),lv)
			if i >= 4 :
				var cha:Chara = team.chas[0]
				cha.isBoss = true
				cha.castBuff(cha,"b_a_boss",3)
			bat()
			var win = yield(self,"onBatEnd")
			if end :return
		else:
			sys.eventDlg.txt(tr("领取如下战利品"))
			sys.eventDlg.items(items)
			items.clear()
			return
	if win == false :return
	sys.eventDlg.txt(tr("完成所有挑战,领取如下战利品"))
	sys.eventDlg.items(items)
	items.clear()

var end = false
func countEnd(win):
	self.win = win
	if win :
		for i in nowItems.items:
			items.addItem(i)
		sys.eventDlg.itemShow(items).lab.text = "胜利！积累了如下战利品"
	else:
		sys.eventDlg.txt(tr("失败！没有拿到任何战利品"))
		end = true
	
func countDeath():
	pass
	
func countMiasma():
	pass

