extends TextureRect

var bf 

func init(bf:Buff):
	if bf.isDel :queue_free()
	self.bf = bf
	texture = data.newRes(bf.icoId)
	bf.connect("onSetLv",self,"_setLv")
	bf.connect("onDel",self,"queue_free")
	_setLv()
	
func _setLv():
	$Label.text = "%d" % bf.lv
	sys.addTip(self,"%s\n%s" % [tr(bf.name),tr(bf.dec)])
