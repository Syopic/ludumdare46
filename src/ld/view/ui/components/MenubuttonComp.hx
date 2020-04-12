package ld.view.ui.components;

import h3d.Vector;
import h2d.filter.Glow;
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
			setFocus(true);
		};
		interactive.onPush = function(_) {
			dom.active = true;
		};
		interactive.onRelease = function(_) {
			dom.active = false;
		};
		interactive.onOut = function(_) {
			setFocus(false);
		};
	}

	public function setFocus(isFocused) {
		if (isFocused) {
			Game.soundManager.playSound(Globals.SFX_SET.UIHover, 0.5);
			labelText.color = new Vector(139 / 255, 149 / 255, 109 / 255, 1);
			labelText.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
		} else {
			labelText.color = new Vector(77 / 255, 83 / 255, 60 / 255, 1);
			labelText.filter = new Glow(Globals.COLOR_SET.Aztec, 0, 0.1);
		}
	}
}