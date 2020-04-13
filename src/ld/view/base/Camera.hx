package ld.view.base;

import h2d.Object;

class Camera extends GameObject {
	public var viewWidth:Int;
	public var viewHeight:Int;
	public var offsetX:Float;
	public var offsetY:Float;

	public var viewX(get, set):Float;
	public var viewY(get, set):Float;

	public function new(parent:Object, width:Int, height:Int, offsetX:Float, offsetY:Float) {
		super(parent);
		this.viewWidth = width;
		this.viewHeight = height;
		this.offsetX = offsetX;
		this.offsetY = offsetY;
	}

	inline function get_viewX() {
		return -this.position.x + this.offsetX;
	}

	inline function get_viewY() {
		return -this.position.y + this.offsetY;
	}

	inline function set_viewX(value:Float) {
		this.position.x = -value + this.offsetX;
		return -value;
	}

	inline function set_viewY(value:Float) {
		this.position.y = -value + this.offsetY;
		return -value;
	}

	override function update(dt:Float) {
		super.update(dt);
	}
}
