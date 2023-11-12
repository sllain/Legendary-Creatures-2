extends "res://tscn/book/tab.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func init():
	if isShow : return
	isShow = true
	if name == "单位" :
		for i in data.getList("c") :
			var item = data.newBase(i.id)
			if item.lock == -1 :continue
			var prof = item.getProfession()
			addProf(prof,item) 

func addProf(prof,cha):
	for i in box.get_children():
		if i.prof == prof :
			i.addCha(cha)
			return
	var pan = preload("res://tscn/book/chasPan.tscn").instance()
	box.add_child(pan)
	pan.init(prof)
	pan.addCha(cha)

func SetAllDisable(bl) :
	for j in box.get_children():
		for i in j.box.get_children() :
			if i.has_node("lock") :
				i.get_node("lock").setDisable(true)
