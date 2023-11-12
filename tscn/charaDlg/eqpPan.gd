extends ScrollContainer


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func drop_data(position, data):
	if data is EqpChaBtn :
		var cha:Chara = data.item.wearer 
		for i in cha.eqps.items.size():
			if cha.eqps.items[i] == data.item :
				cha.setEqp(null,i)
				break

func can_drop_data(pos, data):
	if data is EqpChaBtn:
		return true
	return false
