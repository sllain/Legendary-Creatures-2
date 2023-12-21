extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var modsInfo = {}

class ModInfo:
	extends Resource
	var id = ""
	var dir = ""
	var file = ""
# Called when the node enters the scene tree for the first time.
func _ready():
#	var dt = Directory.new()
#	var dir = OS.get_executable_path().get_base_dir() + "/mods"
#	dt.make_dir_recursive(dir)
#	searchPck(dir)
	
	for i in Steam.getSubscribedItems() :
		var ds = Steam.getItemInstallInfo(i)
		searchPck(ds["folder"])

func _on_Button_pressed():
	queue_free()
	loadMods()
	sys.main.delGame()
	
func searchPck(dirStr):
	var dir = Directory.new()
	dir.open(dirStr)
	dir.list_dir_begin()
	var dname = dir.get_next()
	while dname != "":
#		if dir.current_is_dir() && dname != "core" && dname != "." && dname != "..":
#			searchPck(dirStr + "/" + dname)
		if !dir.current_is_dir() && dname.get_extension() == "pck":
			var modInfo = ModInfo.new()
			modInfo.id = dname.get_basename()
			modInfo.dir = "res://%s" % modInfo.id
			modInfo.file = dirStr+"/"+dname
			modsInfo[dname] = modInfo
			$RichTextLabel.append_bbcode(dname + "\n")
		dname = dir.get_next()
	dir.list_dir_end()
	#minLoadMods("res://mods/")
	
func loadMods():
	for i in modsInfo.values():
		ProjectSettings.load_resource_pack(i.file,true) 
		data.loadDir(i.dir)
		
