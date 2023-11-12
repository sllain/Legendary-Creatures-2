extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var img = $img
var skill

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(skill):
	self.skill = skill
	img.texture = data.newRes("ico_%s" % skill.id)
	if skill.cd == 0:
		$k.texture = preload("res://res/Gui/UiElements/Frame_Square.png")
	
func initTip():
	var cd = skill.cd
	if cd == 0 :
		cd = tr("被动")
	var txt := """
[center][b]{name}[/b]
{tab}
CD: {cd}
{dec}
[/center]
""".format({name=tr(skill.name),cd=cd,dec=skill.getDec(),tab=skill.trTab()})
	var tips = "\n"
	var ts = skill.getDec()
	for i in cons.tipDs:
		if ts.find(tr(i)) != -1:
			tips += "%s:%s\n" % [tr(i),tr(cons.tipDs[i])]
	tips = "[color=#999999]%s[/color]" % tips
	txt += tips
	sys.addTip(self,txt)
