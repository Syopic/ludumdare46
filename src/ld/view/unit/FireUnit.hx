package ld.view.unit;

import h2d.Object;
import h2d.Anim;

class FireUnit extends BaseUnit {

    var anim:Anim;
    public function new(parent:Object) {
        super(parent);
        if (Std.random(3) == 0) {

            var tile = hxd.Res.img.anim.test2.toTile();
            anim = new Anim(tile.split(40), 20, this);
        } else {
            var tile = hxd.Res.img.anim.test.toTile();
            anim = new Anim(tile.split(20), 20, this);
        }
        anim.pause = true;
    }

    override function update(dt:Float) {
        super.update(dt);
        anim.currentFrame += dt * anim.speed;
    }
}