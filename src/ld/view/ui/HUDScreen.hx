package ld.view.ui;

import h2d.filter.Glow;
import h2d.Text;
import hxd.Res;
import h3d.Vector;
import ld.view.ui.components.GamemenuviewComp;
import ld.view.ui.components.MuteSoundButton;
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
	var scoreTF:Text;

	public function new(parent:Object) {
		super(parent);

		var tile = hxd.Res.img.hudScreen.toTile();
		bgImage = new Bitmap(tile, this);

		panelFlow = new h2d.Flow(this);
		panelFlow.padding = 5;

		panelFlow.verticalSpacing = 5;

		panelFlow.paddingTop = 50;
		panelFlow.paddingLeft = 32;

		menuView = new GamemenuviewComp(panelFlow);
		Game.uiManager.style.addObject(menuView);
		panelFlow.visible = false;

		hxd.Window.getInstance().addEventTarget(onEvent);

		scoreTF = new Text(Res.font.gb.toFont());
		
		
		scoreTF.textColor = Globals.COLOR_SET.Como;
		scoreTF.textAlign = Left;
		scoreTF.setPosition(20, 8);
		this.addChild(scoreTF);
		bgImage.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
		scoreTF.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
		
	}

	public function pause() {
		panelFlow.visible = !panelFlow.visible;
		Game.controller.pause(panelFlow.visible);
		if (!panelFlow.visible) {
			menuView.clearAll();
			menuView.currentIndex = 0;
			menuView.changeIndex(0);
		} else
			menuView.continueButton.setFocus(true);
	}

	public function setScore(value:Int) {
		scoreTF.text = value + "";
	}

	function onEvent(event:hxd.Event) {
		// keyboard
		if (event.kind == EKeyDown) {
			if (event.keyCode != Key.ESCAPE && !Game.controller.isPause && Game.uiManager.briefComp != null) {
				Game.uiManager.briefComp.next();
			}
			switch (event.keyCode) {
				case Key.DOWN:
					{
						if (panelFlow.visible)
							menuView.changeIndex(1);
					}
				case Key.UP:
					{
						if (panelFlow.visible)
							menuView.changeIndex(-1);
					}
				case Key.ENTER:
					{
						if (panelFlow.visible)
							menuView.doAction();
					}
				case Key.ESCAPE:
					{
						pause();
					}
			}
		}
	}

	public function dispose() {
		hxd.Window.getInstance().removeEventTarget(onEvent);
		panelFlow.visible = false;
		Game.view.dispose();
	}
}
