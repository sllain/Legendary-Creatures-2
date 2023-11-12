extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal onSel(info)
var btnbl = true

var focusBox = null

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_eventBase_visibility_changed():
	if visible :
		upFocus()

func noPre():
	if btnbl :
		btnbl = false
		call_deferred("noPreTime")
		return false
	return true
	
func noPreTime():
	btnbl = true
		
func upFocus():
	if focusBox == null:
		for i in get_children():
			if i.focus_mode != FOCUS_NONE :
				i.grab_focus()
				#i.call_deferred("grab_focus")
				break
		return
	if focusBox.get_child_count() > 0 :
		focusBox.get_child(0).get_node("Button").grab_focus()
