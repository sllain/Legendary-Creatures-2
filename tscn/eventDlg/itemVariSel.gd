extends NinePatchRect

signal onSel(vari)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var vari
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(vari):
	$variBtn.init(vari)
	self.vari = vari
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	emit_signal("onSel",vari)
