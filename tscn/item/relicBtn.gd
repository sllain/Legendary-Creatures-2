extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var img = $img
var relic :Relic

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(relic):
	self.relic = relic
	img.texture = data.newRes("ico_%s" % relic.id)
	if relic != null:
		$Sprite.modulate = Color(cons.colorDs.lvs[relic.lv-1])
	initTip()
	
func initTip():
	var txt := """
[center][b][color={c}]{name}[/color][/b]
{tab}
{dec}
[/center]
""".format({name=tr(relic.name),dec=relic.getDec(),tab=relic.trTab(),c=cons.colorDs.lvs[relic.lv-1]})
	var tips = "\n"
	for i in cons.tipDs:
		if relic.getDec().find(tr(i)) != -1:
			tips += "%s:%s\n" % [tr(i),tr(cons.tipDs[i])]
	tips = "[color=#999999]%s[/color]" % tips
	txt += tips
	sys.addTip(self,txt)
