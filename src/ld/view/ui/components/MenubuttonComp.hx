package ld.view.ui.components;

@:uiComp("menubutton")
class MenubuttonComp extends h2d.Flow implements h2d.domkit.Object {
    static var SRC = 
		<menubutton>
			<text text={label} public id="labelText"/>
		</menubutton>

	@:p public var label(get, set):String;

	function get_label()
		return labelText.text;

	function set_label(s) {
		labelText.text = s;
		return s;
	}

	public function new(label:String, action:Dynamic, ?parent) {
		super(parent);
		initComponent();

		enableInteractive = true;
		interactive.cursor = Button;
		interactive.onClick = function(_) action();
		interactive.onOver = function(_) {
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
}