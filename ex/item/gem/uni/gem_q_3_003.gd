extends GemUn

func _data():
	name = "时御石"
	tab = "坦克"
	isUnique = true
	
func getDec():
	return tr("每5秒获得%d层抵御") % [per(10)]
	
var sd = 0
func _upS():
	sd += 1 
	if sd >= 5 :
		sd = 0
		masCha.castBuff(masCha,"b_a_diYu",per(10))
