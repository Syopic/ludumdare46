package ld.view.ui.components;

import ld.data.Globals;
import h2d.Flow;

@:uiComp("levelselectview")
class LevelselectviewComp extends h2d.Flow implements h2d.domkit.Object {

	private var currentIndex:Int = 0;

    public function new(?parent) {
        super(parent);
		initComponent();
		// backButton.setFocus(true);
    }

    static var SRC = <levelselectview>
		<flow vertical> 
			<menubutton("PLAY", onPlay, null) public id="playButton"/>
		</flow>
	</levelselectview>;

	public dynamic function onPlay() {
		Game.uiManager.changeScreen(Globals.HUD_SCREEN);
	}
}