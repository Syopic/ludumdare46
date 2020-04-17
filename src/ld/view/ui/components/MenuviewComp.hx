package ld.view.ui.components;

import ld.data.Globals;
import h2d.Flow;

@:uiComp("menuview")
class MenuviewComp extends h2d.Flow implements h2d.domkit.Object {

	public var currentIndex:Int = 0;

    public function new(?parent) {
        super(parent);
		initComponent();
		haxe.Timer.delay(function() {
			startButton.setFocus(true);
		}, 100);
    }

    static var SRC = <menuview>
		<flow vertical id="menu"> 
			<menubutton("START GAME", onStart, clearAll) public id="startButton" />
			<menubutton("CREDITS", onCredits, clearAll) />
			<menubutton("GAME OVER", onGameOver, clearAll) />
			<menubutton("EXIT", onExit, clearAll) />
		</flow>
	</menuview>;

	public dynamic function onStart() {
		trace("onStart" + currentIndex);
		clearAll();
		Game.uiManager.changeScreen(Globals.LEVELSELECT_SCREEN);
	}

	public dynamic function onCredits() {
		trace("onCredits" + currentIndex);
		clearAll();
		Game.uiManager.changeScreen(Globals.CREDITS_SCREEN);
	}

	public dynamic function onGameOver() {
		trace("onGameOver" + currentIndex);
		clearAll();
		Game.uiManager.changeScreen(Globals.GAMEOVER_SCREEN);
	}

	public dynamic function onExit() {
		clearAll();
		trace("onExit" + currentIndex);
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
		cast(menu.children[currentIndex], MenubuttonComp).setFocus(true);
	}

	public function clearAll() {
		// currentIndex = menu.children.length;
		for (i in 0 ... menu.children.length) {
			cast(menu.children[i], MenubuttonComp).setFocus(false);
		}
	}
}