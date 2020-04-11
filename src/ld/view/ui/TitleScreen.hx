package ld.view.ui;

import hxd.Key;
import ld.view.ui.components.MenuviewComp;
import h2d.Bitmap;
import h2d.Object;

class TitleScreen extends h2d.Object {
	var style:h2d.domkit.Style = null;
	var panelFlow = null;
	var bgImage:Bitmap;
	var menuView:MenuviewComp;

	public function new(parent:Object) {
		super(parent);

		var tile = hxd.Res.img.titleScreen.toTile();
		bgImage = new Bitmap(tile, this);

		panelFlow = new h2d.Flow(this);
		panelFlow.padding = 5;

		panelFlow.verticalSpacing = 5;
	
		panelFlow.paddingTop = 80;
		panelFlow.paddingLeft = 32;

		style = new h2d.domkit.Style();
		style.load(hxd.Res.styles.styles);
		menuView = new MenuviewComp(panelFlow);
		style.addObject(menuView);
		hxd.Window.getInstance().addEventTarget(onEvent);
	}

	function onEvent(event:hxd.Event) {
		// keyboard
		if (event.kind == EKeyDown) {
			switch (event.keyCode) {
				case Key.DOWN:
					{
						menuView.changeIndex(1);
					}
				case Key.UP:
					{
						menuView.changeIndex(-1);
					}
				case Key.LEFT:
					{}
				case Key.RIGHT:
					{}
				case Key.ENTER:
					{
						menuView.doAction();
					}
				case Key.ESCAPE:
					{}
			}
		}
	}

	public function update(dt:Float) {
		if (style != null)
			style.sync();
	}

	public function dispose() {
		hxd.Window.getInstance().removeEventTarget(onEvent);
	}
}
