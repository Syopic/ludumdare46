package ld.view;

import ld.view.ui.components.MuteSoundButton;
import ld.view.ui.HUDScreen;
import h2d.domkit.Style;
import ld.view.ui.GameOverScreen;
import ld.data.Globals;
import ld.view.ui.TitleScreen;
import ld.view.ui.CreditsScreen;
import ld.view.ui.GameOverScreen;
import ld.view.ui.TransitionView;
import h2d.Object;

class UIManager extends Object {
	public var style:Style = new Style();

	private var transitionView:TransitionView;
	private var titleScreen:TitleScreen;
	private var creditsScreen:CreditsScreen;
	private var gameOverScreen:GameOverScreen;
	var muteSoundBtn:MuteSoundButton;

	public var hudScreen:HUDScreen;

	private var screenContainer:Object;

	public var currentScreen:String = "";

	public function new(parent:Object) {
		super(parent);
		style.load(hxd.Res.styles.styles);
		screenContainer = new Object(this);
		muteSoundBtn = new MuteSoundButton(this);
		muteSoundBtn.setPosition(144, 8);
		transitionView = new TransitionView(this);
		if (Globals.skipMainMenu)
			changeScreen(Globals.HUD_SCREEN, true);
		else
			changeScreen(Globals.TITLE_SCREEN, true);
	}

	public function changeScreen(screenName:String, isFirst:Bool = false) {
		currentScreen = screenName;
		if (!isFirst)
			transitionView.show();
		Game.soundManager.playSound(Globals.SFX_SET.Transition, 0.5);
		haxe.Timer.delay(function() {
			if (creditsScreen != null) {
				creditsScreen.dispose();
				creditsScreen.remove();
			}
			if (gameOverScreen != null) {
				gameOverScreen.dispose();
				gameOverScreen.remove();
			}
			if (hudScreen != null) {
				hudScreen.dispose();
				hudScreen.remove();
			}
			if (titleScreen != null) {
				titleScreen.dispose();
				titleScreen.remove();
			}
			switch (screenName) {
				case Globals.TITLE_SCREEN:
					{
						Game.soundManager.playSound(Globals.MUSIC_SET.TitleTheme, 0.6, true, true);
						titleScreen = new TitleScreen(screenContainer);
					}
				case Globals.CREDITS_SCREEN:
					{
						creditsScreen = new CreditsScreen(screenContainer);
					}
				case Globals.GAMEOVER_SCREEN:
					{
						gameOverScreen = new GameOverScreen(screenContainer);
					}
				case Globals.HUD_SCREEN:
					{
						
						Game.soundManager.stopSound(Globals.MUSIC_SET.TitleTheme);
						Game.controller.startGame();
						Game.soundManager.playSound(Globals.MUSIC_SET.TitleTheme, 0.6, true, true);
						hudScreen = new HUDScreen(screenContainer);
					}
			}
		}, 200);
	}

	public function update(dt:Float) {
		if (transitionView != null)
			transitionView.update(dt);
	}

	public function dispose() {
		if (titleScreen != null)
			titleScreen.dispose();
		if (creditsScreen != null)
			creditsScreen.dispose();
		if (gameOverScreen != null)
			creditsScreen.dispose();
		if (hudScreen != null)
			hudScreen.dispose();
	}
}
