extends NinePatchRect

signal onSel(skill)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var skill
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(skill:Skill):
	$skillBtn.init(skill)
	self.skill = skill
	$skillBtn.initTip()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	emit_signal("onSel",skill)
