package ld.view;

import ld.view.ui.TitleScreen;
import h2d.Object;

class GameView extends Object {

    private static var titleScreen:TitleScreen;

    public function new(parent:Object) {
        super(parent);
        titleScreen = new TitleScreen(this);
    }

    public function onResize() {
		if (titleScreen != null)
			titleScreen.onResize();
	}

    public function update(dt:Float) {
        if (titleScreen != null)
			titleScreen.update(dt);
    }
}