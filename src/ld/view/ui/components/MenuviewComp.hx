package ld.view.ui.components;

import domkit.Object;

@:uiComp("menuview")
class MenuviewComp extends h2d.Flow implements h2d.domkit.Object {

    public function new(?parent) {
        super(parent);
        initComponent();
    }

    static var SRC = <menuview>
		<flow vertical> 
			<menubutton("START GAME", onStart) public />
			<menubutton("SETTINGS", onExit) public />
			<menubutton("CREDITS", onExit) public />
			<menubutton("EXIT", onExit) public />
		</flow>
	</menuview>;

	public dynamic function onStart() {
		Game.instance.start();
	}

	public dynamic function onExit() {
		// Sys.exit(1);
	}
}