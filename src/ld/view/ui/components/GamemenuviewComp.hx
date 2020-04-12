package ld.view.ui.components;

import ld.data.Globals;
import h2d.Flow;

@:uiComp("gamemenuview")
class GamemenuviewComp extends h2d.Flow implements h2d.domkit.Object {

	public var currentIndex:Int = 0;

    public function new(?parent) {
        super(parent);
		initComponent();
		haxe.Timer.delay(function() {
			changeIndex(0);
		}, 100);
    }

    static var SRC = <gamemenuview>
		<flow vertical id="menu"> 
			<menubutton("CONTINUE", onContinue, clearAll) public id="continueButton" />
			<menubutton("RESTART", onRestart, clearAll) public id="restartButton" />
			<menubutton("MAIN MENU", onMainmenu, clearAll) public id="mainMenuButton" />
		</flow>
	</gamemenuview>;

	public dynamic function onContinue() {
		trace("onContinue");
		clearAll();
		Game.uiManager.hudScreen.pause();
	}

	public dynamic function onRestart() {
		trace("onRestart");
		clearAll();
		Game.uiManager.changeScreen(Globals.HUD_SCREEN);
	}

	public dynamic function onMainmenu() {
		trace("onMainmenu");
		clearAll();
		Game.uiManager.changeScreen(Globals.TITLE_SCREEN);
	}

	public dynamic function doAction() {
		if (currentIndex > menu.children.length - 1) currentIndex = 0;
		cast(menu.children[currentIndex], MenubuttonComp).action();
	}

	public function changeIndex(di) {
		if (currentIndex > menu.children.length - 1) currentIndex = menu.children.length - 1;

		cast(menu.children[currentIndex], MenubuttonComp).setFocus(false);
		currentIndex += di;
		if (currentIndex < 0) currentIndex = menu.children.length - 1;
		if (currentIndex > menu.children.length - 1) currentIndex = 0;
		if (di != 0)
		cast(menu.children[currentIndex], MenubuttonComp).setFocus(true);
	}

	public function clearAll() {
		currentIndex = menu.children.length;
		for (i in 0 ... menu.children.length) {
			cast(menu.children[i], MenubuttonComp).setFocus(false);
		}
	}
}