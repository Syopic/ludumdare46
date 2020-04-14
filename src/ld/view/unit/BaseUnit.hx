package ld.view.unit;

import h2d.Object;
import h2d.Bitmap;
import ld.data.Globals;
import h2d.Tile;
import ld.view.base.GameObject;

class BaseUnit extends GameObject {

    var unit:Bitmap;

    public function new(parent:Object) {
		super(parent);
        // var tile = Tile.fromColor(Globals.COLOR_SET.SpringRain, 5, 5);
		// unit = new Bitmap(tile, this);
    }
    
    override function update(dt:Float) {
        super.update(dt);
    }
}