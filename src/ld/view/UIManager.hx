package ld.view;

import ld.data.Globals;
import ld.view.ui.TitleScreen;
import ld.view.ui.CreditsScreen;
import h2d.Object;

class UIManager extends Object {

    private static var titleScreen:TitleScreen;
    private static var creditsScreen:CreditsScreen;

    public function new(parent:Object) {
        super(parent);
        changeScreen(Globals.TITLE_SCREEN);
    }
    
    public function changeScreen(screenName:String) {
        switch (screenName) {
            case Globals.TITLE_SCREEN: {
                if (creditsScreen != null) {creditsScreen.dispose(); creditsScreen.remove();}
                titleScreen = new TitleScreen(this);
            }
            case Globals.CREDITS_SCREEN: {
                if (titleScreen != null) {titleScreen.dispose(); titleScreen.remove();}
                creditsScreen = new CreditsScreen(this);
            }
        }
    }

    public function update(dt:Float) {
        if (titleScreen != null)
			titleScreen.update(dt);
    }

    public function dispose() {
		if (titleScreen != null)
            titleScreen.dispose();
        if (creditsScreen != null)
			creditsScreen.dispose();
	}
}