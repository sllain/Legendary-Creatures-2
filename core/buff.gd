extends Att
class_name Buff

signal onEff()
signal onSetIco()

var isLong = true #长久 不会每秒消弱的buff
var isDie = false #是否是负面状态
var isVis = false #是否显示在状态栏
var castCha:Chara = null
var masCha:Chara = null
var icoId = "" setget setIco
func setIco(val):
	icoId = val
	emit_signal("onSetIco")
var maxLv = 50
var effId = null #绑定的特效
var plusLv = 0

func loadInfo(id):
	self.id = id
	icoId = "ico_%s" % id
	_data()
	self.lv = lv
	_dataEnd()

func inStart(mas):
	masCha = mas
	castCha = mas
	.inStart(mas)
	self.lv = lv

var s = 0
var bfs = 0
const bfsStup = 0.2
func _process(delta):
	if s < 1 :
		s += delta
		if s >= 1 :
			s = 0
			_upS()	
	if isLong == false:
		if bfs < bfsStup :
			bfs += delta * lvPer(lv,1.0,0.03)
			if bfs >= bfsStup:
				bfs = 0
				setLv(lv - 1)
				if lv <= 0 :
					del()
					
func setLv(val):
	.setLv(val)
	if lv > maxLv :
		lv = maxLv
		emit_signal("onSetLv")
 
func _upS():
	pass
	
func del():
	.del()
	
#按比率造成伤害
func hurtPer(cha,per,hurtType = HURTTYPE.PHY,atkType = ATKTYPE.SKILL):
	var h = mas.atk * per if hurtType != HURTTYPE.MAG else mas.matk * per
	return hurt(cha,h,hurtType,atkType)
	
#按比率造成物理伤害
func hurtPerP(cha,per,atkType = ATKTYPE.SKILL):
	return hurt(cha,mas.atk * per,HURTTYPE.PHY,atkType)
	
#按比率造成魔法伤害
func hurtPerM(cha,per,atkType = ATKTYPE.SKILL):
	return hurt(cha,mas.matk * per,HURTTYPE.MAG,atkType)
	
#造成伤害
func hurt(cha,val,hurtType = HURTTYPE.PHY,atkType = ATKTYPE.SKILL):
	return mas.hurt(cha,val,hurtType,atkType,self)
	
func plusHp(val,cha = null,isEff = true):
	mas.plusHp(val,cha,isEff,self)
	
func plusWard(val,cha = null,isEff = true):
	mas.plusWard(val,cha,isEff,self)
	
func getSave():
	var ds = {
		icoId = icoId,
	}
	ds.merge(.getSave())
	return ds

func setSave(ds):
	.setSave(ds)
	dsSet("icoId",ds)
