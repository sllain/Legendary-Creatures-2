extends Base
class_name Att

signal onAttSet(id)

var maxHp = 0 setget setMaxHp ; func setMaxHp(val):
	maxHp=val;_fAtt("maxHp",val)
var def = 0 setget setDef ; func setDef(val):
	def=val;_fAtt("def",val)
var atk = 0 setget setAtk ; func setAtk(val):
	atk=val;_fAtt("atk",val)
var mdef = 0 setget setMdef ; func setMdef(val):
	mdef=val;_fAtt("mdef",val)
var matk = 0 setget setMatk ; func setMatk(val):
	matk=val;_fAtt("matk",val)
var cri = 0 setget setCri ; func setCri(val):
	cri=val;_fAtt("cri",val)
var criR = 0 setget setCriR ; func setCriR(val):
	criR=val;_fAtt("criR",val)
var ran = 0 setget setRan ; func setRan(val):
	ran=val;_fAtt("ran",val)
var spd = 0 setget setSpd ; func setSpd(val):
	spd=val;_fAtt("spd",val)
var cdSpd = 0 setget setCdSpd ; func setCdSpd(val):
	cdSpd=val;_fAtt("cdSpd",val)
var pen = 0 setget setPen ; func setPen(val):
	pen=val;_fAtt("pen",val)
	
#var ct1 = 0 setget setCt1 ; func setCt1(val):
#	ct1=val;_fAtt("ct1",val)
#var ct2 = 0 setget setCt2 ; func setCt2(val):
#	ct2=val;_fAtt("ct2",val)
#var ct3 = 0 setget setCt3 ; func setCt3(val):
#	ct3=val;_fAtt("ct3",val)
#var ct4 = 0 setget setCt4 ; func setCt4(val):
#	ct4=val;_fAtt("ct4",val)
#var ct5 = 0 setget setCt5 ; func setCt5(val):
#	ct5=val;_fAtt("ct5",val)

var perAddDs = {}
var perMulDs = {}
var onAtt = false
		
func loadInfo(id):
	self.id = id
	_data()
	_dataEnd()
	self.lv = lv
	
func _fAtt(id,val):
	if !onAtt && mas != null:
		mas.addAtt(self)
	emit_signal("onAttSet",id)

#属性百分比叠加
func perAdd(id,val):
	perAddDs[id] = val
	_fAtt(id,val)
#属性百分比相乘
func perMul(id,val):
	perMulDs[id] = val
	_fAtt(id,val)
	
func ifAtt(base):
	for i in cons.attDs:
		if base.get(i) != null && base.get(i) != 0 :
			return true
		if base.perAddDs.has(i) || perMulDs.has(i) :
			return true
	return false
	
#按价值比率 单位 品级 设置属性
func attRatio(ds):
	for i in cons.attDs :
		if ds.has(i) :
			if i == "ran" :
				set(i,ds[i])
			else:
				set(i,ds[i] * cons.attDs[i].rt )

func typeRotio(type = 1):
	attRatio(cons.chaAttDs[type])
