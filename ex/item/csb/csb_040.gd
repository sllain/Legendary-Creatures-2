extends Csb

func _data():
	name = "金币挑战券"
	lock = -1
	tab = "黑店"

func getDec():
	return tr("本场战斗敌方所有单位的增伤和减伤 +50%%，胜利获得 %d * 敌人总等级的金币") %lvPer(lv,50)

var totalLv = 0

func _use():
	var bf = sys.game.player.addAff(data.newBase("b_a_tiaoZhanJinBi"))
	bf.rate = lvPer(lv,50)
	

