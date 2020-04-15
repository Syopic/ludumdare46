package ld.view.thing;

import hxd.Cursor;
import ld.data.Globals;
import h2d.filter.Glow;
import h2d.Interactive;
import h2d.Object;
import h2d.Anim;

class AnimCoinThing extends BaseThing {

    var anim:Anim;
    public function new(parent:Object) {
        super(parent);
        var tile = Game.view.mapDataStorage.tileImage.sub(8, 56, 64, 8);
        anim = new Anim(tile.split(8), 20, this);
        anim.pause = true;

        var interaction = new Interactive(8, 8, this);
        interaction.cursor = Cursor.Button;
		interaction.onOver = function(event:hxd.Event) {
			anim.filter = new Glow(Globals.COLOR_SET.White, 1, 0.1);
        }
        
        interaction.onOut = function(event:hxd.Event) {
			anim.filter = null;
		}
    }

    override function update(dt:Float) {
        super.update(dt);
        anim.currentFrame += dt * anim.speed;
    }
}