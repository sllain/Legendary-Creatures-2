extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



		
	
func _r2(aitem):
	if aitem == null :return
	var g3 = 100 * pow(3,aitem.lv-1) * 0.2
	var inx2 = yield(sys.eventDlg.selBB([tr("支付 %d 金币") % g3,tr("放弃")]),"onSel")
	if inx2 == 0 :
		if sys.player.subItem("m_gold",g3) == false: 
			sys.eventDlg.txt(tr("金币 不足"))
			return
	else:
		return
	var item = data.newBase(aitem.id)
	item.create(aitem.lv)
	sys.player.items.delItem(aitem)
	var itemPck = ItemPck.new()
	itemPck.addItem(item)
	sys.eventDlg.items(itemPck)

func _on_eqpUp_pressed():
	var inx = yield(sys.eventDlg.selBB([tr("升级装备（需要宝石）"),tr("重新随机一个装备的词条"),tr("离开")]),"onSel")
	if inx == 0 :
#		if n1 <= 0 :
#			sys.eventDlg.txt("次数 不足")
#			return
		yield(sys.eventDlg.selBB([tr("选择一个装备")]),"onSel")
		var dlg = sys.newDlg("res://tscn/item/selItemDlg.tscn")
		dlg.init(sys.player.items,1,null,false)
		yield(dlg,"onDel")
		var eqp :Eqp = dlg.selItem
		if eqp == null: return
		yield(sys.eventDlg.selBB([tr("选择一颗比装备高一级的宝石")]),"onSel")
		dlg = sys.newDlg("res://tscn/item/selItemDlg.tscn")
		dlg.init(sys.player.items,4)
		yield(dlg,"onDel")
		if dlg.selItem == null :return
		var gem = dlg.selItem
		if gem.lv - eqp.lv != 1 :
			sys.eventDlg.txt(tr("宝石必须比装备高一级"))
			return
		var g2 = int(100 * pow(3,eqp.lv-1) * 0.5)
		var inx2 = yield(sys.eventDlg.selBB([tr("支付 %d 金币") % g2,tr("放弃")]),"onSel")
		if inx2 == 0 : 
			if sys.player.subItem("m_gold",g2) == false :
				sys.eventDlg.txt(tr("金币 不足"))
				return
		else:
			return
		sys.player.items.delItem(gem)
		eqp.plusLv(gem)
		var itemPck = ItemPck.new()
		itemPck.addItem(eqp)
		sys.eventDlg.itemShow(itemPck)
	elif inx == 1 :
		var dlg = sys.newDlg("res://tscn/item/selItemDlg.tscn")
		dlg.init(sys.player.items,1,null,false)
		dlg.connect("onSel",self,"_r2")
