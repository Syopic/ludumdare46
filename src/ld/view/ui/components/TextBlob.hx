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

class TextBlob extends GameObject {
	var bg:Bitmap;
	var messageTF:Text;
	var container:Object;

	public function new(text:String, duration:Int, ?parent:Object) {
		super(parent);
		container = new Object(this);
		messageTF = new Text(Res.font.gb.toFont());
		messageTF.textColor = Globals.COLOR_SET.TimberGreen;
		messageTF.textAlign = Left;
		messageTF.text = text;
		var tile = Tile.fromColor(Globals.COLOR_SET.SpringRain, Std.int(messageTF.textWidth) + 1, Std.int(messageTF.textHeight));
		bg = new Bitmap(tile, container);
		bg.setPosition(-2, 0);
		bg.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
		container.addChild(messageTF);
		container.setPosition(-Std.int(tile.width / 2), -tile.height); 

		if (duration > 0) {
			haxe.Timer.delay(function() {
				Game.uiManager.hideTextBlob(guid);
			}, duration);
		}
	}

	override function update(dt:Float) {
		super.update(dt);
	}

	public function dispose() {}
}