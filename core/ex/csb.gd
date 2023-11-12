extends Item
class_name Csb #消耗品

func _init():
	._init()
	priceBase = 50
	isNum = true
	
func use():
	self.num -= 1
	_use()
	
func _use():
	pass

func setLv(val):
	.setLv(val)
	priceBase = 50 * pow(2,lv-1)
	setNum(num)
