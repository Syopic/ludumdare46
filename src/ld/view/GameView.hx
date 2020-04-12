package ld.view;

import h2d.Tile;
import ld.data.Globals;
import h2d.Bitmap;
import h2d.Object;
import ld.view.unit.BaseUnit;

class GameView extends Object {

	var container:Object;
	var unit:BaseUnit;

	public function new(parent:Object) {
		super(parent);
		container = new Object(this);
	}

	public function init() {
		var tile = Tile.fromColor(Globals.COLOR_SET.SpringRain, 5, 5);
		unit = new BaseUnit(container);
		unit.position.y = 20;
	}

	public function update(dt:Float) {
		if (unit != null) {
			unit.position.x += 0.1;
			unit.update(dt);
		}
	}

	public function dispose() {
		// container.removeChildren();
		unit.remove();
	}
}
