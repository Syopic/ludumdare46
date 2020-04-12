package ld.view.base;

import ld.utils.Utils;
import h2d.col.Point;
import h2d.Object;

class GameObject extends h2d.Object {
	public var guid:String;
	public var position:Point = new Point();

	public function new(?parent:Object) {
		super(parent);
		guid = Utils.uid();
	}

	public function applyPixelPerfect() {
		setPosition(Math.round(position.x), Math.round(position.y));
	}

	public function update(dt:Float) {
		applyPixelPerfect();
	}
}
