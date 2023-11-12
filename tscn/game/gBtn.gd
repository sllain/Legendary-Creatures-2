extends ImgBtn

var g :Global

func init(g:Global):
	self.g = g
	g.connect("onSetIsVisIco",self,"_onSetVisType")
	sys.game.connect("onToMap",self,"_onToMap")
	_onSetVisType()
	g.connect("onSetTxt",self,"_setTxt")
	_setTxt()
	g.connect("onSetDec",self,"_setDec")
	_setDec()
	
func _onSetVisType():
	visible = g.isVisIco
	if visible == false :return
	setImg(data.newRes(g.icoId))

func _setTxt():
	setText(tr(g.txt))

func _setDec():
	sys.addTip(self,"[center][b]%s[/b][/center]\n%s" % [tr(g.name),tr(g.dec)])

func _onToMap(id):
	_onSetVisType()

func _on_gBtn_pressed():
	g._pressed()
