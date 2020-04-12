package ld.view.ui;

import ld.view.ui.components.GameoverviewComp;
import ld.data.Globals;
import hxd.Key;
import ld.view.ui.components.MenuviewComp;
import h2d.Flow.FlowAlign;
import h2d.Bitmap;
import h2d.Object;

class GameOverScreen extends h2d.Object {
	var style:h2d.domkit.Style = null;

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

		
		style = new h2d.domkit.Style();
		style.load(hxd.Res.styles.styles);
		menuView = new GameoverviewComp(panelFlow);
		style.addObject(menuView);

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

	public function update(dt:Float) {
		if (style != null)
			style.sync();
	}

	public function dispose() {
		hxd.Window.getInstance().removeEventTarget(onEvent);
	}
}
