package ld.view.ui;

import ld.utils.console.ConsoleController;
import hxd.Timer;
import hxd.res.DefaultFont;
import h2d.Text;
import ld.data.Globals;
import h2d.Object;

class DebugPanel extends h2d.Object {
    var fpsTF:Text;
	public var console:ConsoleController;


	public function new(parent:Object) {
        super(parent);
        console = new ConsoleController(parent);

		fpsTF = new Text(DefaultFont.get(), this);
		
		fpsTF.textColor = Globals.COLOR_SET.Como;
		fpsTF.textAlign = Left;
		fpsTF.setPosition(0, 16);
    }
    
    public function update(dt) {
        fpsTF.text = "FPS: " + hxd.Math.ceil(Timer.fps());
    }

}
