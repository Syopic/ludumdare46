package ld.view.ui.components;

import ld.data.Globals;
import h2d.Flow;

@:uiComp("creditsview")
class CreditsviewComp extends h2d.Flow implements h2d.domkit.Object {

	private var currentIndex:Int = 0;

    public function new(?parent) {
        super(parent);
		initComponent();
		backButton.setFocus(true);
    }

    static var SRC = <creditsview>
		<flow vertical> 
			<menubutton("BACK", onBack, null) public id="backButton"/>
		</flow>
	</creditsview>;

	public dynamic function onBack() {
		Game.uiManager.changeScreen(Globals.TITLE_SCREEN);
	}
}