package ld.view;

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
    private var screenContainer:Object;
    

    public function new(parent:Object) {
        super(parent);
        style.load(hxd.Res.styles.styles);
        screenContainer = new Object(this);
        transitionView = new TransitionView(this);
        changeScreen(Globals.TITLE_SCREEN);
        // titleScreen = new TitleScreen(screenContainer);
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