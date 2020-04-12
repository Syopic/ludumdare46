package ld.view.ui;

import ld.view.ui.components.GameoverviewComp;
import ld.data.Globals;
import hxd.Key;
import h2d.Bitmap;
import h2d.Object;

class GameOverScreen extends h2d.Object {
	var bgImage:Bitmap;
	var menuView:GameoverviewComp;

	public function new(parent:Object) {
		super(parent);

		var tile = hxd.Res.img.gameoverScreen.toTile();
		bgImage = new Bitmap(tile, this);

		var panelFlow = new h2d.Flow(this);
		panelFlow.padding = 5;

		panelFlow.verticalSpacing = 5;

		panelFlow.paddingTop = 110;
		panelFlow.paddingLeft = 32;
		
		menuView = new GameoverviewComp(panelFlow);
		Game.uiManager.style.addObject(menuView);

		hxd.Window.getInstance().addEventTarget(onEvent);
	}

	function onEvent(event:hxd.Event) {
		// keyboard
		if (event.kind == EKeyDown) {
			menuView.backButton.setFocus(true);
			switch (event.keyCode) {
				case Key.ENTER:
					Game.uiManager.changeScreen(Globals.TITLE_SCREEN);
				case Key.ESCAPE:
					Game.uiManager.changeScreen(Globals.TITLE_SCREEN);
			}
		}
	}

	public function dispose() {
		hxd.Window.getInstance().removeEventTarget(onEvent);
	}
}
