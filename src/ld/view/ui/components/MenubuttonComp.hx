package ld.view.ui.components;

import ld.data.Globals;

@:uiComp("menubutton")
class MenubuttonComp extends h2d.Flow implements h2d.domkit.Object {
    static var SRC = 
		<menubutton>
			<text text={label} public id="labelText"/>
		</menubutton>

	@:p public var label(get, set):String;
	public var action:Dynamic;

	function get_label()
		return labelText.text;

	function set_label(s) {
		labelText.text = s;
		return s;
	}

	public function new(label:String, action:Dynamic, clearAction:Dynamic, ?parent) {
		super(parent);
		this.action = action;
		initComponent();

		enableInteractive = true;
		interactive.cursor = Button;
		interactive.onClick = function(_) action();
		interactive.onOver = function(_) {
			if (clearAction != null)
			clearAction();
			Game.soundManager.playSound(Globals.SFX_SET.Test1, 1);
			dom.hover = true;
			labelText.dom.hover = true;
		};
		interactive.onPush = function(_) {
			dom.active = true;
		};
		interactive.onRelease = function(_) {
			dom.active = false;
		};
		interactive.onOut = function(_) {
			dom.hover = false;
			labelText.dom.hover = false;
		};
	}

	public function setFocus(isFocused) {
		if (isFocused) {
			Game.soundManager.playSound(Globals.SFX_SET.Test1, 1);
			dom.hover = true;
			labelText.dom.hover = true;
		} else {
			dom.hover = false;
			labelText.dom.hover = false;
		}
	}
}