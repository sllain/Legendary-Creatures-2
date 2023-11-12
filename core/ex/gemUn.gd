extends Gem
class_name GemUn #特殊宝石

func _init():
	._init()
	isUnique = true


func createRndLv(lv,minLv = 2,maxLv = 999):
	var rlv = 1
	for i in lv :
		var v = rnp.lvPool.rndItem()
		if v > rlv : rlv = v
	rlv = clamp(rlv,minLv,maxLv)
	rlv = clamp(rlv,4,5)
	self.lv = rlv	
	return self

func per(val):
	return lvPer(lv-3,val)
