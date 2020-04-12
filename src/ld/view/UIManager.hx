package ld.view;

import ld.view.ui.GameOverScreen;
import ld.data.Globals;
import ld.view.ui.TitleScreen;
import ld.view.ui.CreditsScreen;
import ld.view.ui.GameOverScreen;
import ld.view.ui.TransitionView;
import h2d.Object;

class UIManager extends Object {

    private var transitionView:TransitionView;
    private var titleScreen:TitleScreen;
    private var creditsScreen:CreditsScreen;
    private var gameOverScreen:GameOverScreen;
    private var screenContainer:Object;

    public function new(parent:Object) {
        super(parent);
        screenContainer = new Object(this);
        transitionView = new TransitionView(this);
        titleScreen = new TitleScreen(screenContainer);
    }

    public function changeScreen(screenName:String) {
        transitionView.show();
        Game.soundManager.playSound(Globals.SFX_SET.Transition, 1);
        // Game.soundManager.stopSound(Globals.MUSIC_SET.TitleTheme);
        haxe.Timer.delay(function() {
            switch (screenName) {
                case Globals.TITLE_SCREEN: {
                    // Game.soundManager.playSound(Globals.MUSIC_SET.TitleTheme, 0.7);
                    titleScreen = new TitleScreen(screenContainer);
                    if (creditsScreen != null) {creditsScreen.dispose(); creditsScreen.remove(); }
                    if (gameOverScreen != null) {gameOverScreen.dispose(); gameOverScreen.remove(); }
                }
                case Globals.CREDITS_SCREEN: {
                    if (titleScreen != null) {titleScreen.dispose(); titleScreen.remove();}
                    creditsScreen = new CreditsScreen(screenContainer);
                }
                case Globals.GAMEOVER_SCREEN: {
                    if (titleScreen != null) {titleScreen.dispose(); titleScreen.remove();}
                    gameOverScreen = new GameOverScreen(screenContainer);
                }
            }
        }, 300);
    }

    public function update(dt:Float) {
        if (titleScreen != null)
			titleScreen.update(dt);
        if (creditsScreen != null)
            creditsScreen.update(dt);
        if (gameOverScreen != null)
            gameOverScreen.update(dt);
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
	}
}