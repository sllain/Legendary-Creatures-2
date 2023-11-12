extends Item
class_name Gem #宝石

var isUnique = false

func _init():
	._init()

func setLv(val):
#	if val <= 1 :
#		val = 2
	.setLv(val)
	priceBase = 50 * pow(3,lv-1)
	setNum(num)

func createRndLv(lv,minLv = 2,maxLv = 999):
	var rlv = 1
	for i in lv :
		var v = rnp.lvPool.rndItem()
		if v > rlv : rlv = v
	rlv = clamp(rlv,minLv,maxLv)
	rlv = clamp(rlv,2,3)
	self.lv = rlv	
	return self



