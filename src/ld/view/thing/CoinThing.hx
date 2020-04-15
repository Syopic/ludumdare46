package ld.view.thing;

import h2d.Bitmap;
import h2d.Object;
import h2d.Anim;

class CoinThing extends BaseThing {

    public function new(parent:Object) {
        super(parent);
        var tile = Game.controller.mapDataStorage.getTileById(113);
        new Bitmap(tile, this);
    }
}