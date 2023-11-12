extends Obj
class_name Conter   #效果的容器 

signal onAddAff(base) #获得附属物时
signal onDelAff(base) #移除附属物时

var affs = [] #效果列表
var atts = [] #属性列表

func upAtt(base):
	for i in cons.attDs:
		if base.get(i) == null : continue
		if base.get(i) != 0 || base.perAddDs.has(i) || base.perMulDs.has(i): 
			rAttSet(i)
			
func upAllAtt():
	for i in atts:
		upAtt(i)

func rAttSet(id):
	var val = 0.0
	var per = 1.0
	var mul = 1.0
	for i in atts:
		if i.get(id) == null: continue
		val += i[id]
		if i.perAddDs.has(id) :
			per += i.perAddDs[id]
		if i.perMulDs.has(id) :
			mul *= 1.0 + i.perMulDs[id]
	set(id,val*per*mul)

func del():
	delAllAff()
	.del()

#添加附属物  属性，buff，天赋，技能 效果 
func addAff(base):
	if base != null: base.scene = scene
	if base == null:return
	if affs.has(base) :return base
	affs.append(base)
	if ifAtt(base) :
		if addAtt(base):upAtt(base)
	base.inStart(self)
	emit_signal("onAddAff",base)
	base.connect("onDel",self,"_delAff",[base])
	return base

#删除附属物
func delAff(base): 
	if base != null :
		_delAff(base)
		base.del()
		
func delIdAff(id):
	for i in range(affs.size()-1,-1,-1):
		if affs[i].id == id :
			delAff(affs[i])
		
func _delAff(base): 
	if affs.has(base):
		#base.del()
		affs.erase(base)
		delAtt(base)
		emit_signal("onDelAff",base)
		base.disconnect("onDel",self,"_delAff")
	return base
	
func addAtt(base):
	if atts.has(base) : return false
	base.connect("onAttSet",self,"rAttSet")
	atts.append(base)
	onAtt = true
	return true
	
func delAtt(base):
	if atts.has(base):
		atts.erase(base)
		if base.is_connected("onAttSet",self,"rAttSet"):
			base.disconnect("onAttSet",self,"rAttSet")
		upAtt(base)
	
#查找是否有目标id的Aff	
func hasAff(id):
	for i in affs:
		if i.id == id :
			return i
	return null

func delAllAff():
	for i in range(affs.size()-1,-1,-1):
		delAff(affs[i])
		
