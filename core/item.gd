extends Buff
class_name Item

signal onSetWearer()

var price = 100
var priceId = "m_gold"
var maxNum = 99999
var isActive = true #是否主动使用
var wearer = null setget setWearer
var priceBase = 0
var inx = 0
var canSell = true
var isOnly = false  #是否唯一的，也就是专属

func _init():
	._init()
	maxLv = 7
	
func loadInfo(id):
	.loadInfo(id)
	setNum(num)

func setWearer(val):
	wearer = val
	emit_signal("onSetWearer")
	

func setNum(val):
	num = val
	if num > maxNum :
		num = maxNum
	price = priceBase * num
	if num <= 0 :
		sys.player.items.delItem(self)
	emit_signal("onSetNum")
	return self

func subNum(val):
	if num >= val :
		self.num -= val
		return true
	return false

func getSave():
	var ds = {
		num = num,
		price = price
	}
	ds.merge(.getSave())
	return ds

func setSave(ds):
	.setSave(ds)
	dsSet("num",ds)
	dsSet("price",ds)

