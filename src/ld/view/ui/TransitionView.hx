package ld.view.ui;

import tweenxcore.Tools.Easing;
import tweenx909.TweenX;
import tweenx909.EaseX;
import ld.data.Globals;
import h2d.Tile;
import h2d.Bitmap;
import h2d.Object;

using tweenxcore.Tools;

class TransitionView extends Object {
	private var tintUp:Bitmap;
	private var tintDown:Bitmap;
	private var isShow:Bool = true;
	private var onComplete:Dynamic;
    private var frameCount = 10;

	public function new(parent:Object) {
		super(parent);
		var tile = Tile.fromColor(Globals.COLOR_SET.Clear, Globals.STAGE_WIDTH, 72);
		tintUp = new Bitmap(tile, this);
		tintDown = new Bitmap(tile, this);
	}

	public function show() {
		frameCount = 0;
		isShow = true;
	}

	public function update(dt:Float) {
		var rate = frameCount / 10;

		if (rate <= 1) {
			tintUp.y = rate.linear().lerp(-Globals.STAGE_HEIGHT / 2, 0);
			tintDown.y = rate.linear().lerp(Globals.STAGE_HEIGHT, Globals.STAGE_HEIGHT / 2);
		} else
			isShow = false;

		if (isShow)
			frameCount++;
		else
			frameCount--;
	}
}
