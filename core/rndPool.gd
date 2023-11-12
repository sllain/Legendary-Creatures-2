extends Reference
class_name RndPool
#随机池
var items = []
var weight = 0

func _init(ss = null):
	if ss != null:
		reSetItems(ss)
		
func getSave():
	var its = []
	for i in items:
		its.append([i[0].id,i[1]])
	var dc = {
		its = its,
		weight = weight
	}
	return dc

func reSetItems(ss):
	items.clear()
	weight = 0
	for i in ss:
		addItem(i[0],i[1])
	pass
#添加元素（元素，该元素权重值：数值型）
func addItem(item,weight=1):
	items.append([item,weight])
	self.weight += weight
#按权重获得一个元素(筛选函数所在对象：Object，函数名:String)
func rndItem(obj = null,funcName = null):
	if obj == null: #无筛选获取
		var r = rand_range(0,weight)
		var s = 0
		for i in range(items.size()):
			s += items[i][1]
			if s >= r :
				return items[i][0]
		return null
	else:#有筛选获取
		var ls = []
		var w = 0
		for i in items:
			if obj.call(funcName,i[0]) :
				ls.append(i)
				w += i[1]
		var r = rand_range(0,w)
		var s = 0
		for i in range(ls.size()):
			s += ls[i][1]
			if s >= r :
				return ls[i][0]
		return null
		
#从池中删除目标物品
func delItem(item):
	for i in items:
		if i[0] == item :
			items.erase(i)
		
#获取目标元素权重值（目标元素）
func getItemW(item):
	for i in items:
		if i[0] == item : return i[1]
#设置目标元素的权重值（目标元素，权重）
func setItemW(item,w):
	for i in items:
		if i[0] == item : i[1] = w
#清空池
func clear():
	items.clear()
	weight = 0
	
