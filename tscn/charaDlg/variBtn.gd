extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var vari
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(vari):
	if vari != null:
		texture_normal = data.newRes(vari.icoId)
		self.vari = vari
		var txt = "\n[b][color=%s]%s\n[/color][/b]" % [cons.colorDs.lvs[2],vari.name]
		txt += "[color=%s]%s[/color]\n"  % [cons.colorDs.lvs[2],vari.dec]
		sys.addTip(self,txt)
