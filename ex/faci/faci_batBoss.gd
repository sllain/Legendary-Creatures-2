extends FaciBat
class_name FaciBatBoss

func _data():
	name = "BOSS"
	dec = "消灭可减少瘴气，获得神徽"
	weight = 0.5
	tab = "world"
	powM = 25
	xp = 100
	num = nums.size()
	canPerfect = false
	gold = 100

const nums = [1,1,2,2,3,4]
	
func _createStart():
	createLv = nums[0]
	nums.remove(0)
		
func bonus(itemPck:ItemPck):
	var item = data.newBase("m_gold")
	item.num = lvPer(lv,gold * bonusR)
	itemPck.addItem(item)
	item = data.newBase("m_xp")
	item.num = nowXp
	itemPck.addItem(item)
	itemPck.addItem(getRndEqp(lv+1))
	
	item = data.newBase("m_cry")
	item.num = lvPer(lv,10,0.3) * lvPer(sys.game.diffLv,1,0.05) * bonusR
	itemPck.addItem(item)
	
func enemyInit(powM,lv):
	.enemyInit(powM,lv)
	initBoss()
	
func enemyBuff():
	.enemyBuff()
	var cha:Chara = team.chas[0]
	buffBoss(cha)
	
func initBoss():
	var cha:Chara = team.chas[0]
	cha.isBoss = true
	cha.addRndItem(clamp(cha.lv-1,1,5))
var bossBuffLv = 2
func buffBoss(cha):
	cha.castBuff(cha,"b_a_boss",bossBuffLv)

func countEnd(win):
	.countEnd(win)
	if win :
		trigInfo("bossDel")
		if sys.game.mode == "tower" :
			relicDlg()
			return
		var ls2 = [
				tr("减少 2级瘴气"),
				tr("获得 神徽")
			]
		var inx2 = yield(sys.eventDlg.selBB(ls2),"onSel")
		if inx2 == 0 :
			sys.game.globals.g_m.lv -= 2
		else:
			relicDlg()
		
