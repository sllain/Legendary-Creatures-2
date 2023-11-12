extends Node

var chaPool :RndPool
var gemPool :RndPool
var gemUnPool :RndPool
var eqpPool :RndPool
var eqpoPool :RndPool
var csbPool :RndPool
var materPool :RndPool
var buffPool :RndPool
var skillPool :RndPool

var lvPool:RndPool
var relic :RndPool

var subPoolDs = {}

func init():
	chaPool = getRndPool("c")
	csbPool = getRndPool("csb")
	materPool = data.getRndPool("m")
	buffPool = data.getRndPool("b")
	eqpPool = getRndPool("eqp")
	eqpoPool = getRndPool("eqpo")
	skillPool = getRndPool("k")
	relic = getRndPool("r")
	lvPool = RndPool.new([[1,256],[2,64],[3,16],[4,4],[5,0]])
	subPoolDs.clear()
	for i in data.getList("faci"):
		var item = data.newBase(i.id) 
		if item.checkMode(sys.game.mode) == false:continue
		if data.isUsable(item) == false:
			sys.game.ach(item)
			continue
		var ls = i.id.split("_")
		if ls.size() > 2 :
			var ld = "%s_%s" % [ls[0],ls[1]]
			if subPoolDs.has(ld) == false:
				subPoolDs[ld] = RndPool.new()
			subPoolDs[ld].addItem(item,item.weight)
	
	gemPool = RndPool.new()
	gemUnPool = RndPool.new()
	for i in data.getList("gem"):
		var item:Gem = data.newBase(i.id)
		if data.isUsable(item) == false :continue
		if item.checkMode(sys.game.mode) == false:continue
		if item.isUnique :
			gemUnPool.addItem(item,item.weight)
		else:
			gemPool.addItem(item,item.weight)

func getRndPool(ty):
	var pool = RndPool.new()
	for i in data.getList(ty):
		var item = data.newBase(i.id) 
		if item.checkMode(sys.game.mode) == false:continue
		if data.isUsable(item) : 
			pool.addItem(item,item.weight)
		else:
			sys.game.ach(item)
	return pool


