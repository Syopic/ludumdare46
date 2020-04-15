package ld.view;

import ld.view.base.GameObject;
import h2d.filter.Glow;
import h2d.TileGroup;
import h2d.col.Point;
import hxd.Cursor;
import h2d.Mask;
import h2d.Interactive;
import h2d.col.Bounds;
import ld.utils.particles.ParticleSystem;
import ld.utils.particles.ParticleHelper;
import h2d.Tile;
import ld.data.Globals;
import h2d.Bitmap;
import h2d.Object;
import ld.view.unit.BaseUnit;
import ld.view.base.Camera;
import ld.data.MapDataStorage;
import ld.view.thing.AnimCoinThing;
import ld.view.thing.CoinThing;

class GameView extends Object {
	public var mapDataStorage:MapDataStorage;

	var container:Object;
	var ps:ParticleSystem;
	var camera:Camera;
	var objects:Array<GameObject> = new Array<GameObject>();
	var interaction:Interactive;
	var sandTiledGroup:TileGroup;
	var bushTiledGroup:TileGroup;
	var objectsTiledGroup:TileGroup;

	public function new(parent:Object) {
		super(parent);
		var mask:Mask = new Mask(Globals.STAGE_WIDTH, Globals.STAGE_HEIGHT, this);
		camera = new Camera(mask, Globals.STAGE_WIDTH, Globals.STAGE_HEIGHT, Globals.STAGE_WIDTH / 2, Globals.STAGE_HEIGHT / 2);
		// var tile = hxd.Res.img.gameoverScreen.toTile();
		// var bgImage = new Bitmap(tile, camera);
	}

	public function init() {
		dispose();
		mapDataStorage = new MapDataStorage(hxd.Res.map);
		sandTiledGroup = new TileGroup(mapDataStorage.tileImage, camera);
		bushTiledGroup = new TileGroup(mapDataStorage.tileImage, camera);
		objectsTiledGroup = new TileGroup(mapDataStorage.tileImage, camera);
		bushTiledGroup.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
		objectsTiledGroup.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);

		drawMap();
		// var fireUnit:FireUnit = new FireUnit(camera);
		// fireUnit.position = new Point(40, 40);
		// units.push(fireUnit);


		interaction = new Interactive(Globals.STAGE_WIDTH, Globals.STAGE_HEIGHT, this);
		interaction.propagateEvents = true;
		interaction.onMove = function(event:hxd.Event) {
			camera.viewX = event.relX;
			camera.viewY = event.relY;
		}
		interaction.cursor = Cursor.Default;
		ps = new ParticleSystem(camera);
	}

	public function drawMap() {
		for (y in 0...mapDataStorage.mapHeight) {
			for (x in 0...mapDataStorage.mapWidth) {
				var tid = mapDataStorage.getTileId(x, y, 0);
				if (tid != 0)
					sandTiledGroup.add(x * mapDataStorage.tileWidth, y * mapDataStorage.tileHeight, mapDataStorage.getTileById(tid - 1));
				tid = mapDataStorage.getTileId(x, y, 1);
				if (tid != 0)
					bushTiledGroup.add(x * mapDataStorage.tileWidth, y * mapDataStorage.tileHeight, mapDataStorage.getTileById(tid - 1));
			}
		}

		var mapObjects = mapDataStorage.getObjects();

		for (obj in mapObjects) {
			// sandTiledGroup.add(obj.x, obj.y - obj.height, tiles[obj.gid - 1]);

			var coin = new AnimCoinThing(camera);
			objects.push(coin);
			coin.position.x = obj.x;
			coin.position.y = obj.y - obj.height;
		}
	}

	public function update(dt:Float) {
		for (obj in objects) {
			if (obj != null) {
				// obj.position.x += 0.1;
				obj.update(dt);
				Game.uiManager.hudScreen.setScore(Std.int(obj.position.x));
				// ps.addParticle(ParticleHelper.fontan(Std.int(unit.position.x + 2), Std.int(unit.position.y), Globals.COLOR_SET.Como));
				if (obj.position.x > Globals.STAGE_WIDTH) {
					obj.position.x = 0;
					obj.position.y = Std.random(144);
				}
			}
		}
		if (ps != null) {
			ps.update(dt);
		}

		camera.update(dt);
	}

	public function dispose() {
		for (obj in objects) {
			obj.remove();
			obj = null;
		}
		objects = new Array<GameObject>();
		if (ps != null)
			ps.dispose();

		if (interaction != null) {
			interaction.remove();
			interaction = null;
		}
	}
}
