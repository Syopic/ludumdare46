package ld.view.ui;

import ld.view.ui.components.GamemenuviewComp;
import ld.data.Globals;
import hxd.Key;
import ld.view.ui.components.MenuviewComp;
import h2d.Flow.FlowAlign;
import h2d.Bitmap;
import h2d.Object;

class HUDScreen extends h2d.Object {
	var bgImage:Bitmap;
	var menuView:GamemenuviewComp;
	var panelFlow:h2d.Flow;

	public function new(parent:Object) {
		super(parent);

		var tile = hxd.Res.img.hudScreen.toTile();
		bgImage = new Bitmap(tile, this);

		panelFlow = new h2d.Flow(this);
		panelFlow.padding = 5;

		panelFlow.verticalSpacing = 5;

		panelFlow.paddingTop = 55;
		panelFlow.paddingLeft = 32;

		menuView = new GamemenuviewComp(panelFlow);
		Game.uiManager.style.addObject(menuView);
		panelFlow.visible = false;

		hxd.Window.getInstance().addEventTarget(onEvent);
	}

	
	function onEvent(event:hxd.Event) {
		// keyboard
		if (event.kind == EKeyDown) {
			menuView.restartButton.setFocus(true);
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
					menuView.doAction();
				case Key.ESCAPE:
					panelFlow.visible = !panelFlow.visible;
			}
		}
	}

	public function dispose() {
		hxd.Window.getInstance().removeEventTarget(onEvent);
		panelFlow.visible = false;
	}
}
