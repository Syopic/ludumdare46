package ld;

import ld.data.Globals;
import ld.data.GameConfig;
import ld.view.GameView;
import ld.sound.SoundManager;

class Game extends hxd.App {

	public static var instance:Game;
	// public static var controller:GameController;
	public static var view:GameView;
	// public static var uiManager:UIManager;
	public static var soundManager:SoundManager;

	static function main() {
		hxd.Res.initEmbed();
		instance = new Game();
	}

	override function init() {
		soundManager = new SoundManager();
		soundManager.playSound("track1");
		view = new GameView(s2d);
		onResize();
	}

	public function start() {
		haxe.Timer.delay(function() {
			dispose();
			instance = new Game();
		}, 0);
	}

	override function onResize() {
		if (view != null) {
			var scaleCoef:Float = Math.min(hxd.Window.getInstance().width / (Globals.STAGE_WIDTH * Globals.SCALE_FACTOR), hxd.Window.getInstance().height / (Globals.STAGE_HEIGHT * Globals.SCALE_FACTOR));
			view.setScale(scaleCoef * Globals.SCALE_FACTOR) ;
			view.x = hxd.Window.getInstance().width / 2 - (Globals.STAGE_WIDTH * Globals.SCALE_FACTOR / 2) * scaleCoef;
			view.y = hxd.Window.getInstance().height / 2 - (Globals.STAGE_HEIGHT * Globals.SCALE_FACTOR / 2) * scaleCoef;
			view.onResize();
		}
	}

	override function update(dt:Float) {
		if (view != null)
			view.update(dt);
	}
}
