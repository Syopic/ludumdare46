package ld;

import ld.data.MapDataStorage;
import ld.utils.shaders.OverlayTexture;
import ld.data.Globals;
import ld.controller.GameController;
import ld.view.UIManager;
import ld.view.GameView;
import ld.sound.SoundManager;
import ld.view.ui.DebugPanel;
import ld.utils.console.ConsoleController;

class Game extends hxd.App {
	public static var instance:Game;
	public static var controller:GameController;
	public static var uiManager:UIManager;
	public static var view:GameView;
	public static var soundManager:SoundManager;
	public static var debugPanel:DebugPanel;
	public static var mapDataStorage:MapDataStorage;

	static function main() {
		hxd.Res.initEmbed();
		instance = new Game();
	}

	override function init() {
		soundManager = new SoundManager();
		// soundManager.playSound(Globals.MUSIC_SET.TitleTheme);
		controller = new GameController();
		mapDataStorage = controller.mapDataStorage;
		view = new GameView(s2d);
		uiManager = new UIManager(s2d);
		var ot = new OverlayTexture(4);
		ot.alpha = 0.12;
		s2d.filter = ot;

		debugPanel = new DebugPanel(s2d);
		onResize();
	}

	public function restart() {
		haxe.Timer.delay(function() {
			dispose();
			view.remove();
			uiManager.remove();
			view = null;
			uiManager = null;
			instance = new Game();
		}, 0);
	}

	override function onResize() {
		var scaleCoef:Float = Math.min(hxd.Window.getInstance().width / (Globals.STAGE_WIDTH * Globals.SCALE_FACTOR),
			hxd.Window.getInstance().height / (Globals.STAGE_HEIGHT * Globals.SCALE_FACTOR));
		if (uiManager != null) {
			uiManager.setScale(scaleCoef * Globals.SCALE_FACTOR);
		}

		if (view != null) {
			view.setScale(scaleCoef * Globals.SCALE_FACTOR);
		}
		s2d.x = hxd.Window.getInstance().width / 2 - (Globals.STAGE_WIDTH * Globals.SCALE_FACTOR / 2) * scaleCoef;
		s2d.y = hxd.Window.getInstance().height / 2 - (Globals.STAGE_HEIGHT * Globals.SCALE_FACTOR / 2) * scaleCoef;
		debugPanel.x = (Globals.STAGE_WIDTH * Globals.SCALE_FACTOR) * scaleCoef - 60;
		debugPanel.y = (Globals.STAGE_HEIGHT * Globals.SCALE_FACTOR) * scaleCoef - 50;
	}

	override function update(dt:Float) {
		if (uiManager != null)
			uiManager.update(dt);

		if (controller != null)
			controller.update(dt);
		if (debugPanel != null)
			debugPanel.update(dt);
	}

	override function dispose() {
		super.dispose();
		if (uiManager != null)
			uiManager.dispose();

		if (view != null)
			view.dispose();
	}
}
