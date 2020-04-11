package ld.view.ui;

import ld.data.Globals;
import hxd.Key;
import ld.view.ui.components.MenuviewComp;
import h2d.Flow.FlowAlign;
import h2d.Bitmap;
import h2d.Object;

class CreditsScreen extends h2d.Object {
	var bgImage:Bitmap;

	public function new(parent:Object) {
		super(parent);

		var tile = hxd.Res.img.creditsScreen.toTile();
		bgImage = new Bitmap(tile, this);
		hxd.Window.getInstance().addEventTarget(onEvent);
	}

	function onEvent(event:hxd.Event) {
		// keyboard
		if (event.kind == EKeyDown) {
			switch (event.keyCode) {
				case Key.ESCAPE:
					{
						Game.uiManager.changeScreen(Globals.TITLE_SCREEN);
					}
			}
		}
	}

	public function dispose() {
		hxd.Window.getInstance().removeEventTarget(onEvent);
	}
}
