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
	public var isFocused:Bool = false;

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
			// if (!this.isFocused)
			// 	// Game.soundManager.playSound(Globals.SFX_SET.UIHover, 0.5);
			labelText.textColor = Globals.COLOR_SET.Como;

			labelText.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
			this.isFocused = true;
		} else {
			labelText.textColor = Globals.COLOR_SET.TimberGreen;
			labelText.filter = new Glow(Globals.COLOR_SET.Aztec, 0, 0.1);
			this.isFocused = false;
		}
	}
}