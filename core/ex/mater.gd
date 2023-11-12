extends Item
class_name Mater #材料

var isHomeShow = false #是否出现在主页

func _init():
	._init()
	isNum = true

func setNum(val):
	num = val
	if num > maxNum :
		num = maxNum
	price = priceBase * num
	if num <= 0 && isHomeShow == false:
		sys.player.items.delItem(self)
	emit_signal("onSetNum")
	return self
