package ld.view;

import h2d.Tile;
import ld.data.Globals;
import h2d.Bitmap;
import h2d.Object;

class GameView extends Object {

	var container:Object;
	var unit:Bitmap;

	public function new(parent:Object) {
		super(parent);
		container = new Object(parent);
	}

	public function init() {
		var tile = Tile.fromColor(Globals.COLOR_SET.SpringRain, 20, 20);
		unit = new Bitmap(tile, container);
		unit.y = 20;
	}

	public function update(dt:Float) {
		if (unit != null) {
			unit.x ++;
		}
	}

	public function dispose() {
		// container.removeChildren();
		unit.remove();
	}
}
