extends Node
signal onSetCry()

var infoDs = {}
var resDs = {}
var lockDs = {}
var disableDs = {}
var cry = 0 setget setCry
var skills = ItemPck.new()
func setCry(val):
	cry = val
	emit_signal("onSetCry")

func _init():
	connect("tree_entered",self,"init")
	pass	
	
func init():
	loadDir("res://ex")
	if sys.isDemo == false:
		loadDir("res://ex2")
		loadDir("res://ex3")
	loadLock()
	
	for i in data.getList("k") :
		var item = data.newBase(i.id) 
		if data.isUsable(item) : 
			skills.addItem(item)
	
func loadDir(dirStr):
	var dir = Directory.new()
	dir.open(dirStr)
	dir.list_dir_begin()
	var dname = dir.get_next()
	while dname != "":
		if dir.current_is_dir() && dname != "core" && dname != "." && dname != "..":
			loadDir(dirStr + "/" + dname)
		else :
			var ext = dname.split(".")
			if ext.size() < 2 || (ext[1] in ["gd","png","webp","jpg","tscn"]) == false: 
				dname = dir.get_next()
				continue
			var ds = {
				id = ext[0],
				type = ext[1],
				dir = "%s/%s.%s" % [dirStr,ext[0],ext[1]]
			}
			var ty = ds.id.split("_")[0]
			if infoDs.has(ty) == false: infoDs[ty] = {}
			infoDs[ty][ds.id] = ds
		dname = dir.get_next()
	dir.list_dir_end()
	
#创建指定id的实例
func newBase(id):
	var base = load(infoDs[id.split("_")[0]][id].dir).new()
	base.loadInfo(id)
	return base
func getInfo(id):
	pass
	
var nullPng = preload("res://icon.png")
#创建指定id的资源
func newRes(id):
	if id == "" :
		push_error("id为空的资源")
		return nullPng
	if resDs.has(id) == false:
		if infoDs[id.split("_")[0]].has(id) == false:
			push_error("读取%s 资源错误" % id)
			return nullPng
		var res = load(infoDs[id.split("_")[0]][id].dir)
		resDs[id] = res
		return res
	return resDs[id]
#获取指定类型的数据列表
func getList(tName):
	return infoDs[tName].values()

func getRndPool(ty):
	var pool = RndPool.new()
	for i in data.getList(ty):
		var item = newBase(i.id) 
		if item.lock == 1 : pool.addItem(item)
	return pool

func ulock(item):
	var p = item.lockVal
	if cry > p :
		self.cry -= p
		lockDs[item.id] = true
		return true
	return false
	
func achUlock(item):
	lockDs[item.id] = true
	saveLock()
	
func setDisable(item,disable = false):
	if disable == false:
		disableDs.erase(item.id)
	else:
		disableDs[item.id] =  true
		
func isUsable(item):
	if item.lock == 1 :return true
	if item.lock == -1 :return false
	if lockDs.has(item.id) && disableDs.has(item.id) == false:
		return true
	return false

func loadLock():
	var file = File.new()
	if  file.open("%s/lock.data" % sys.dataDir, File.READ) == OK :
		var dic = file.get_var()
		file.close()
		if dic == null:
			print_debug("读取存档错误")
			return
		lockDs = dic.lockDs
		disableDs = dic.disableDs
		self.cry = dic.cry
		return dic
		
func saveLock():
	var file = File.new()
	var dir = Directory.new()
	dir.make_dir_recursive("%s" % sys.dataDir)
	var dic = {
		lockDs = lockDs,
		disableDs = disableDs,
		cry = cry,
	}
	if file.open("%s/lock.data" % sys.dataDir, File.WRITE) == OK:
		file.store_var(dic)
		file.close()
