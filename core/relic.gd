extends Item
class_name Relic

func inStart(mas):
	self.mas = mas
	_in()

func _init():
	maxLv = 3
	lvPerVal = 1

func _inScene():
	pass
