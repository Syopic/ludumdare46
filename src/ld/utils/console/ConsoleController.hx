package ld.utils.console;

import hxd.res.DefaultFont;
import ld.utils.console.CustomConsole;
import h2d.Object;
import ld.data.Globals;

class ConsoleController {
	public var console:CustomConsole;

	public function new(parent:Object) {
		console = new CustomConsole(DefaultFont.get(), parent);
		
		console.addCommand("version", "Show current version", [], function() {
			log(Globals.VERSION);
		});

		console.addCommand("screen", "Show current screen", [], function() {
			log(Game.uiManager.currentScreen);
		});

		console.addAlias("v", "version");
		console.addAlias("s", "screen");
	}

	public function runCommand(cmd:String) {
		if (console != null)
			console.runCommand(cmd);
	}

	public function log(cmd:String) {
		if (console != null) {
			console.log(cmd, Globals.COLOR_SET.Como);
		}
	}
}
