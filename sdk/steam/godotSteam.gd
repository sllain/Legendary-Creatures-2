extends Node 

var on = false
signal on_item_created()
signal on_item_updated()
signal onUpEnd()

func _ready():
	pass

func init():
	var init = Steam.steamInit()
	if init["status"] != 1:
		sys.get_tree().quit()
		
#	var init = Steam.steamInitEX(true)
#	if init["status"] != 0:
#		sys.get_tree().quit()

	on = true
	var fenzhi = Steam.getCurrentBetaName()
	#print("分支:",fenzhi)
	if fenzhi == "test" :
		sys.isBeta = true
	print(fenzhi)
#	Steam.connect("leaderboard_find_result",self,"_leaderboard_find_result")
#	Steam.connect("leaderboard_score_uploaded",self,"_leaderboard_uploaded")
	Steam.connect("item_created",self,"_item_created")
	Steam.connect("item_updated",self,"_item_updated")
	#Steam.findLeaderboard("tongGuan")
	#createItem()
	#itemUpdate()

func _leaderboard_find_result(aa,bb):
	print_debug("接入排行榜")

func _leaderboard_uploaded(a,b,c,d,f):
	print_debug("上传得分")

func _process(delta):
	Steam.run_callbacks()
	
func getSteamUILanguage():
	return Steam.getSteamUILanguage()

func upScore(val):
	if on == false:return
	Steam.uploadLeaderboardScore(val,true)

func createItem():
	Steam.createItem(Steam.getAppID(),0)
var nowItemId	
func _item_created(m_eResult,m_nPublishedFileId,m_bUserNeedsToAcceptWorkshopLegalAgreement):
	nowItemId = m_nPublishedFileId
	print_debug(nowItemId)
	if m_eResult == 1: 
		print_debug("创建物品成功 id:%s" % nowItemId)
	else:
		print_debug("创建物品失败",m_eResult)
	emit_signal("on_item_created")

func itemUpdate(id,tile,info,dir,png):
	var h = Steam.startItemUpdate(Steam.getAppID(),id)
	#Steam.startItemUpdate(Steam.getAppID(),id)
	Steam.setItemTitle(h,tile)
	Steam.setItemDescription(h,info)
	Steam.setItemUpdateLanguage(h,"english")
	#Steam.setItemMetadata(h,"")#：设置物品的任意元数据。 这些元数据可从查询返回，无需下载安装实际内容。
	Steam.setItemVisibility(h,0) #：设置物品可见度。
	#Steam.setItem#：在物品上设置任意开发者指定标签。
	#Steam.addItemKeyValueTag(h,"chara")#为物品添加键值标签对。 不同的键可对应多个不同的值（一对多关系）。
	#Steam.RemoveItemKeyValueTags：移除物品现有键值标签。
	#Steam.setItemContent(h,"C:/Users/Administrator/Desktop/i_test")#：设置保存物品内容的文件夹。
	#Steam.setItemPreview(h,"C:/Users/Administrator/Desktop/2.png")#设定物品的主要预览图片。
	Steam.setItemContent(h,dir)#：设置保存物品内容的文件夹。
	Steam.setItemPreview(h,png)#设定物品的主要预览图片。

	Steam.submitItemUpdate(h,"")

	#Steam.getItemInstallInfo()

func item_Up(id,tile,info,dir,png):
	if id != null:
		nowItemId = id
		itemUpdate(id,tile,info,dir,png)
	else:
		createItem()
		yield(self,"on_item_created")
		itemUpdate(nowItemId,tile,info,dir,png)
		print("等待更新")
		yield(self,"on_item_updated")
		if true :
			pass
		else:
			Steam.deleteItem(nowItemId)
	emit_signal("onUpEnd")

var isUpdata = false
func _item_updated(m_eResult,m_bUserNeedsToAcceptWorkshopLegalAgreement):
	if m_eResult == 1:
		print_debug("更新物品成功")
		isUpdata = true
		Steam.activateGameOverlayToWebPage("steam://url/CommunityFilePage/%d" % nowItemId)
		sys.newAcpDlg("物品上传成功。id:%s" % nowItemId)
	else:
		print_debug("更新物品失败",m_eResult)
		isUpdata = false
		sys.newAcpDlg("物品上传失败。id:%s" % nowItemId)
	emit_signal("on_item_updated")

func ach(id):
	if on :
		Steam.setAchievement(id)
			
func loadMod():
	var dir = Directory.new()
	var dirStr = Steam.getAppInstallDir(Steam.getAppID()).directory + "/cache"
	dir.make_dir_recursive(dirStr)
	print("载入测试mod")
	dir = Directory.new()
	dirStr = Steam.getAppInstallDir(Steam.getAppID()).directory + "/mods"
	dir.make_dir_recursive(dirStr)
	data.loadDir(dirStr)
	print(data.disableDs)
	for i in Steam.getSubscribedItems() :
		var id = str(i)
		var bl = true
		if data.disableDs.has(int(i)) :
			bl = false
		if bl :
			print(id)
			var dc = Steam.getItemInstallInfo(i)
			data.loadDir(dc["folder"])


