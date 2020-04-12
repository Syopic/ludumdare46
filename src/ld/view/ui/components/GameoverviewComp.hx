package ld.view.ui.components;

import ld.data.Globals;
import h2d.Flow;

@:uiComp("gameoverview")
class GameoverviewComp extends h2d.Flow implements h2d.domkit.Object {

	private var currentIndex:Int = 0;

    public function new(?parent) {
        super(parent);
		initComponent();
		// backButton.setFocus(true);
    }

    static var SRC = <gameoverview>
		<flow vertical> 
			<menubutton("MAIN MENU", onBack, null) public id="backButton"/>
		</flow>
	</gameoverview>;

	public dynamic function onBack() {
		Game.uiManager.changeScreen(Globals.TITLE_SCREEN);
	}
}