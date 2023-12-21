extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var comDlg = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init():
	popup()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	updata()
	

func _on_Button2_pressed():
	pck($Panel/dir/Label.text)

func _on_Button_mod_pressed():
	$FileDialog.popup()

func _on_png_pressed():
	$FileDialog2.popup()
	pass # Replace with function body.

func _on_FileDialog_dir_selected(dir):
	openDir(dir)
	
func openDir(dir):
	$Panel/dir/Label.text = dir
	var dt = Directory.new()
	dt.make_dir_recursive("%s/res" % dir)
	dt.make_dir_recursive("%s/pck" % dir)
	var file_name = $Panel/dir/Label.text + "/itemId.dic"
	var file = File.new()
	if  file.open(file_name, File.READ) == OK :
		var dic = parse_json(file.get_line())
		if dic == null:print_debug("读取存档错误")
		if dic.has("id"):$Panel/id.text = str(dic["id"])
		if dic.has("tile"):$Panel/tile/LineEdit.text = dic["tile"]
		if dic.has("info"):$Panel/info/LineEdit.text = dic["info"]
		if dic.has("dir"):$Panel/dir/Label.text = dic["dir"]
		if dic.has("png"):$Panel/file/Label.text = dic["png"]
		file.close()

func _on_FileDialog2_file_selected(path):
	$Panel/file/Label.text = path
	
func setDic():
	if $Panel/tile/LineEdit.text == "" :
		sys.newMsg("标题还未填写。")
		return
	elif $Panel/info/LineEdit.text == "" :
		sys.newMsg("描述还未填写。")
		return
	elif $Panel/dir/Label.text == "" :
		sys.newMsg("未选择目录。")
		return
	elif $Panel/file/Label.text == "" :
		sys.newMsg("未选择封面图。")
		return
	var file = File.new()
	var dic = {
		id=$Panel/id.text,
		tile = $Panel/tile/LineEdit.text,
		info = $Panel/info/LineEdit.text,
		dir = $Panel/dir/Label.text,
		png = $Panel/file/Label.text
	}
	file.open($Panel/dir/Label.text + "/itemId.dic", File.WRITE)
	file.store_line(to_json(dic))
	file.close()
	return dic

func updata():
	if setDic() == null:
		return
	var dlg = sys.newDlg("res://tscn/mod/modCom.tscn")
	dlg.addText("上传中-请等待")
	var file_name = $Panel/dir/Label.text + "/itemId.dic"
	var file = File.new()
	var itemId = null
	if  file.open(file_name, File.READ) == OK :
		var dic = parse_json(file.get_line())
		file.close()
		if dic == null:print_debug("读取存档错误")
		if dic.has("id"):itemId = dic["id"]
	sys.godotSteam.item_Up(itemId,$Panel/tile/LineEdit.text,$Panel/info/LineEdit.text,$Panel/dir/Label.text+"/res",$Panel/file/Label.text)
	yield(sys.godotSteam,"on_item_updated")
	dlg.addText("完成")
	dlg.end()

func _on_wenhao_pressed():
	sys.newMsg("请把你制作的若干mod，放到同一个文件夹里，然后选择这个文件夹。之后请保留这个文件夹，下次读取并上传它，会更新相应的创意工坊的物品。")
	
func pck(path):
	var dic = setDic()
	if dic == null:return
	var filename = $Panel/id.text
	if dic.id == "":filename = path.get_file()
	var pck = PCKPacker.new()
	var pckPath = "%s/pck/%s.pck" % [path, filename]
	pck.pck_start(pckPath)
	pathSize = path.get_base_dir().length()
	var dlg = sys.newDlg("res://tscn/mod/modCom.tscn")
	dlg.addText("打包中，请等待")
	comDlg = dlg
	yield (get_tree().create_timer(0.3), "timeout")
	forDir(path+"/res", pck)
	pck.flush()
	dlg.addText("打包完成")
	dlg.addText(pckPath)
	dlg.end()
	
func comDlgPrint(txt):
	if is_instance_valid(comDlg) :
		comDlg.addText(txt)
	
var pathSize = 0
func forDir(path, pck):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var pathName = path + "/" + file_name
		while file_name != "":
			if dir.current_is_dir():
				if file_name != "." and file_name != "..":
					comDlgPrint("dir: " + pathName)
					forDir(pathName, pck)
			else :
				var resPath = "res://mods" + pathName.right(pathSize)
				pck.add_file(resPath, pathName)
				comDlgPrint("file: %s" % [resPath])
				comDlgPrint("to: %s" % [pathName])
			file_name = dir.get_next()
			pathName = path + "/" + file_name
	else :
		comDlgPrint("err")
