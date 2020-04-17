package ld.view;

import hxd.Res;
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
import ld.view.ui.components.BriefComp;

class UIManager extends Object {
	public var style:Style = new Style();

	private var transitionView:TransitionView;
	private var titleScreen:TitleScreen;
	private var creditsScreen:CreditsScreen;
	private var gameOverScreen:GameOverScreen;
	public var briefComp:BriefComp;
	var muteSoundBtn:MuteSoundButton;

	public var hudScreen:HUDScreen;

	private var inGameContainer:Object;
	private var screenContainer:Object;

	public var currentScreen:String = "";

	public function new(parent:Object) {
		super(parent);
		style.load(hxd.Res.styles.styles);
		inGameContainer = new Object(this);
		screenContainer = new Object(this);
		muteSoundBtn = new MuteSoundButton(this);
		muteSoundBtn.setPosition(144, 8);
		transitionView = new TransitionView(this);
		if (Globals.skipMainMenu) {

			changeScreen(Globals.HUD_SCREEN, true);
		}
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
						showBrief();
						Game.soundManager.playSound(Globals.MUSIC_SET.TitleTheme, 0.6, true, true);
						hudScreen = new HUDScreen(screenContainer);
					}
			}
		}, 200);
	}

	public function showBrief() {
		hideBrief();
		if (briefComp == null) {
			briefComp = new BriefComp(inGameContainer);
			briefComp.addMessage({img: Res.img.textBlobHeroLeft.toTile(), text: "What the...?\nIm surrounded!\nthird textline", isLeft:true});
			briefComp.addMessage({img: Res.img.textBlobHeroRight.toTile(), text: "Ho.. ho.. ho..!\nIm superman!", isLeft:false});
			briefComp.start();
			// briefComp.addMessage("What the...1?\nIm surrounded!");
			// briefComp.addMessage("Ho.. ho.. ho..!\nIm superman!");
		}
	}

	public function hideBrief() {
		if (briefComp != null) {
			briefComp.remove();
			briefComp.dispose();
			briefComp = null;
		}
	}

	public function update(dt:Float) {
		if (transitionView != null)
			transitionView.update(dt);

		if (briefComp != null && !Game.controller.isPause)
			briefComp.update(dt);
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
		if (briefComp != null)
			briefComp.dispose();
	}
}
