extends Relic

func _data():
	name = "急行军"
	excMode = "tower"
	
func getDec():
	return tr("玩家移动时，时间的流逝减缓%d%%") % [lvPer(lv,10)]

var lastLv = 0.0

func _in():
	lastLv = sys.game.timeNext
	r()

func setLv(val):
	.setLv(val)
	r()

func r():
	if is_instance_valid(sys.game) == false || sys.player.relics.items.has(self) == false:return
	sys.game.timeNext = lastLv
	sys.game.timeNext *= 1.0-lvPer(lv,0.1)
	lastLv = sys.game.timeNext

