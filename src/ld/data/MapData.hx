package ld.data;

class MapData {
	public var rows(default, null):Int;
	public var cols(default, null):Int;

	private var mapData:Array<Bool> = new Array<Bool>();

	public function new(p_cols:Int, p_rows:Int) {
		cols = p_cols;
		rows = p_rows;
	}

	public function isWalkable(x:Int, y:Int):Bool {
		return !mapData[(y * cols) + x];
	}

	public function setWalkable(x:Int, y:Int, value:Bool) {
		mapData[(y * cols) + x] = !value;
	}
}
