package ld.view.ui;

import h2d.filter.Glow;
import ld.data.Globals;
import hxd.Key;
import ld.view.ui.components.MenuviewComp;
import h2d.Bitmap;
import h2d.Object;

class TitleScreen extends h2d.Object {
	var panelFlow = null;
	var bgImage:Bitmap;

	public var menuView:MenuviewComp;

	public function new(parent:Object) {
		super(parent);

		var tile = hxd.Res.img.titleScreen.toTile();
		bgImage = new Bitmap(tile, this);

		panelFlow = new h2d.Flow(this);
		panelFlow.padding = 5;

		panelFlow.verticalSpacing = 5;

		panelFlow.paddingTop = 80;
		panelFlow.paddingLeft = 32;

		menuView = new MenuviewComp(panelFlow);
		Game.uiManager.style.addObject(menuView);
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
				case Key.ENTER:
					{
						menuView.doAction();
					}
				case Key.ESCAPE:
					{
						// Sys.exit(1);
					}
			}
		}
	}

	public function dispose() {
		hxd.Window.getInstance().removeEventTarget(onEvent);
	}
}
