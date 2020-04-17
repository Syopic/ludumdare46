package ld.view.ui;

import ld.view.ui.components.LevelselectviewComp;
import h2d.filter.Glow;
import h2d.Text;
import hxd.Res;
import h3d.Vector;
import ld.view.ui.components.GamemenuviewComp;
import ld.view.ui.components.MuteSoundButton;
import ld.data.Globals;
import hxd.Key;
import ld.view.ui.components.MenuviewComp;
import ld.view.ui.components.LevelItem;
import h2d.Flow.FlowAlign;
import h2d.Bitmap;
import h2d.Object;

class LevelSelectScreen extends h2d.Object {
	var bgImage:Bitmap;
	var menuView:LevelselectviewComp;
	var currentLevel:Int = 1;
	var levelTF:Text;

	public function new(parent:Object) {
		super(parent);

		var tile = hxd.Res.img.levelSelectScreen.toTile();
		bgImage = new Bitmap(tile, this);

		var panelFlow = new h2d.Flow(this);
		panelFlow.padding = 5;

		panelFlow.verticalSpacing = 5;

		panelFlow.paddingTop = 110;
		panelFlow.paddingLeft = 32;
		
		// menuView = new LevelselectviewComp(panelFlow);
		// Game.uiManager.style.addObject(menuView);

		levelTF = new Text(Res.font.gb.toFont(), this);
		
		
		// levelTF.textColor = Globals.COLOR_SET.Como;
		// levelTF.textAlign = Center;
		// levelTF.setPosition(80, 72);
		// levelTF.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);

		// levelTF.text = Std.string(currentLevel);

		for (i in 0 ... 5) {
			var li:LevelItem = new LevelItem(i + 1, i < 3, onLevelSelect, this);
			li.setPosition(i * 25 + 21, 60);
		}
		for (i in 5 ... 10) {
			var li:LevelItem = new LevelItem(i + 1, i < 3, onLevelSelect, this);
			li.setPosition((i - 5) * 25 + 21, 85);
		}

		hxd.Window.getInstance().addEventTarget(onEvent);
	}

	function onLevelSelect(level:Int) {
		trace(level);
		Game.uiManager.changeScreen(Globals.HUD_SCREEN);
	}

	function onEvent(event:hxd.Event) {
		// keyboard
		if (event.kind == EKeyDown) {
			// menuView.playButton.setFocus(true);
			switch (event.keyCode) {
				case Key.ENTER:
					Game.uiManager.changeScreen(Globals.HUD_SCREEN);
				case Key.ESCAPE:
					Game.uiManager.changeScreen(Globals.TITLE_SCREEN);
			}
		}
	}

	public function dispose() {
		hxd.Window.getInstance().removeEventTarget(onEvent);
	}
}
