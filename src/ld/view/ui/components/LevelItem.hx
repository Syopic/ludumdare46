package ld.view.ui.components;

import ld.view.base.GameObject;
import hxd.Cursor;
import h2d.Interactive;
import h3d.Vector;
import hxd.Res;
import h2d.Text;
import h2d.filter.Glow;
import h2d.Bitmap;
import h2d.Tile;
import ld.data.Globals;
import h2d.Object;

class LevelItem extends GameObject {
	var bg:Bitmap;
	var numTF:Text;
	var container:Object;
	var ebabled:Bool = false;

	public function new(levelNum:Int, isEnable:Bool, onAction:Dynamic, ?parent:Object) {
		super(parent);
		container = new Object(this);
		var tile = Tile.fromColor(isEnable ? Globals.COLOR_SET.Como : Globals.COLOR_SET.Aztec, 18, 18);
		bg = new Bitmap(tile, container);
		bg.filter = new Glow(isEnable ? Globals.COLOR_SET.Aztec : Globals.COLOR_SET.Clear, 1, 0.1);
		numTF = new Text(Res.font.gb.toFont(), this);
		numTF.setPosition(levelNum < 10 ? 11 : 10, 4);
		numTF.textColor = Globals.COLOR_SET.TimberGreen;
		numTF.textAlign = Center;
		numTF.text = Std.string(levelNum);

		if (isEnable) {
			var interaction = new Interactive(18, 18, this);
			interaction.cursor = Cursor.Button;
			interaction.onOver = function(event:hxd.Event) {
				bg.filter = new Glow(Globals.COLOR_SET.White, 1, 0.1);
			}

			interaction.onOut = function(event:hxd.Event) {
				bg.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
			}

			interaction.onClick = function(event:hxd.Event) {
				bg.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
				onAction(levelNum);
			}
		}
	}

	override function update(dt:Float) {
		super.update(dt);
	}

	public function dispose() {}
}
