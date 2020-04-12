package ld;

import ld.data.Globals;
import ld.data.GameConfig;
import ld.controller.GameController;
import ld.view.UIManager;
import ld.view.GameView;
import ld.sound.SoundManager;

class Game extends hxd.App {
	public static var instance:Game;
	public static var controller:GameController;
	public static var uiManager:UIManager;
	public static var view:GameView;
	public static var soundManager:SoundManager;

	static function main() {
		hxd.Res.initEmbed();
		instance = new Game();
	}

	override function init() {
		soundManager = new SoundManager();
		// soundManager.playSound(Globals.MUSIC_SET.TitleTheme);
		controller = new GameController();
		view = new GameView(s2d);
		uiManager = new UIManager(s2d);
		onResize();
	}

	public function restart() {
		haxe.Timer.delay(function() {
			dispose();
			view.remove();
			uiManager.remove();
			view = null;
			uiManager =null;
			instance = new Game();
		}, 0);
	}

	override function onResize() {
		var scaleCoef:Float = Math.min(hxd.Window.getInstance().width / (Globals.STAGE_WIDTH * Globals.SCALE_FACTOR),
			hxd.Window.getInstance().height / (Globals.STAGE_HEIGHT * Globals.SCALE_FACTOR));
		if (uiManager != null) {
			uiManager.setScale(scaleCoef * Globals.SCALE_FACTOR);
			uiManager.x = hxd.Window.getInstance().width / 2 - (Globals.STAGE_WIDTH * Globals.SCALE_FACTOR / 2) * scaleCoef;
			uiManager.y = hxd.Window.getInstance().height / 2 - (Globals.STAGE_HEIGHT * Globals.SCALE_FACTOR / 2) * scaleCoef;
		}

		if (view != null) {
			view.setScale(scaleCoef * Globals.SCALE_FACTOR);
			view.x = hxd.Window.getInstance().width / 2 - (Globals.STAGE_WIDTH * Globals.SCALE_FACTOR / 2) * scaleCoef;
			view.y = hxd.Window.getInstance().height / 2 - (Globals.STAGE_HEIGHT * Globals.SCALE_FACTOR / 2) * scaleCoef;
		}
	}

	override function update(dt:Float) {
		if (uiManager != null)
			uiManager.update(dt);

		if (controller != null)
			controller.update(dt);
	}

	override function dispose() {
		super.dispose();
		if (uiManager != null)
			uiManager.dispose();

		if (view != null)
			view.dispose();

	}
}
