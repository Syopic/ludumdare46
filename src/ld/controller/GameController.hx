package ld.controller;

import ld.data.MapDataStorage;

class GameController {
	public var mapDataStorage:MapDataStorage;

	public var isPause:Bool = false;

	public function new() {
		mapDataStorage = new MapDataStorage(hxd.Res.map);
	}

	public function startGame() {
		Game.view.dispose();
		Game.view.init();
		this.isPause = false;
	}

	public function pause(isPause:Bool) {
		this.isPause = isPause;
	}

	public function update(dt:Float) {
		if (!this.isPause && Game.view != null)
			Game.view.update(dt);
	}

	public function dispose() {}
}
