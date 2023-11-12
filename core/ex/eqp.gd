extends Item
class_name Eqp #装备

var gems := ItemPck.new()
var attBase = {}
var baseName = ""

func _init():
	._init()
	lvPerVal = 0.2
	
func create(lv):
	gems.clear()
	self.lv = lv
	
	for i in lv:
		if i < 3 :
			plusGem(i+1)
		else:
			plusGemUnique(i+1)
	return self
	
func createFor(eqp):
	for i in eqp.gems.items:
		var gem = data.newBase(i.id)
		gem.lv = i.lv
		gems.addItem(gem)
		
func plusLv(gem):
	self.lv += 1
	gems.addItem(gem)
	
func plusGem(lv):
	var gem = data.newBase(rnp.gemPool.rndItem(self,"rndCreate").id)
	gems.addItem(gem)
	gem.lv = lv
	return gem
	
func plusGemUnique(lv):
	var gem = data.newBase(rnp.gemUnPool.rndItem(self,"rndCreateUnique").id)
	gems.addItem(gem)
	gem.lv = lv
	return gem
	
func createRndLv(lv,minLv = 1,maxLv = 999):
	var rlv = 1
	for i in lv :
		var v = rnp.lvPool.rndItem()
		if v > rlv : rlv = v
	rlv = clamp(rlv,minLv,maxLv)
	return create(clamp(rlv,1,self.maxLv)) 

func rndCreate(item):
	if item.hasOrTab(tab) == false: return false
	for i in gems.items:
		if i.id == item.id:
			return false
	return true
	
func rndCreateUnique(item):
	if item.hasOrTab(tab) == false: return false
	for i in gems.items:
		if i.id == item.id:
			return false
	return true

func setLv(val):
	for i in cons.attDs:
		if attBase.has(i) :
			set(i,lvPer(val,attBase[i])) 
	.setLv(val)
	priceBase = 100 * pow(3,lv-1)
	setNum(num)
	if isOnly :
		icoId = "ico_%s" % id
		name = baseName
		return
	name = "%s %s" % [tr(cons.lvStr[lv-1]),tr(baseName)]
	if lv > 1:icoId = "ico_%s_%d" % [id,clamp(lv,1,5)]
	else:icoId = "ico_%s" % id
	
func inStart(mas):
	.inStart(mas)
	for i in gems.items :
		mas.addAff(i)
	#connect("onDel",self,"_eqpDel")
	
func loadInfo(id):
	self.id = id
	_data()
	baseName = name
	_dataEnd()
	setLv(lv)
	
func _dataEnd():
	._dataEnd()
	for i in cons.attDs:
		if get(i) != 0 :
			attBase[i] = get(i)
	for i in gems.items:
		mas.delAff(i)
		
func del():
	.del()
	for i in gems.items:
		if i != null : i.del()

func getSave():
	var gemL = []
	var ds = {
		gems = gems.getSave()
	}
	ds.merge(.getSave())
	return ds

func setSave(ds):
	.setSave(ds)
	gems = ItemPck.new().setSave(ds.gems)

#按价值比率 单位 品级 设置属性
func attRatio(ds):
	for i in cons.attDs :
		if ds.has(i) :
			set(i,ds[i] * cons.attDs[i].rt)
