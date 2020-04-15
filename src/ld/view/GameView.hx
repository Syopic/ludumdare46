package ld.view;

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
import ld.view.unit.FireUnit;
import ld.view.base.Camera;
import ld.data.MapDataStorage;

class GameView extends Object {
	var container:Object;
	var unit:BaseUnit;
	var ps:ParticleSystem;
	var camera:Camera;
	var units:Array<BaseUnit> = new Array<BaseUnit>();
	var interaction:Interactive;
	var mds:MapDataStorage;
	var tileImage:Tile;
	var sandTiledGroup:TileGroup;
	var bushTiledGroup:TileGroup;
	var objectsTiledGroup:TileGroup;

	public function new(parent:Object) {
		super(parent);
		var mask:Mask = new Mask(Globals.STAGE_WIDTH, Globals.STAGE_HEIGHT, this);
		camera = new Camera(mask, Globals.STAGE_WIDTH, Globals.STAGE_HEIGHT, Globals.STAGE_WIDTH / 2, Globals.STAGE_HEIGHT / 2);
		tileImage = hxd.Res.img.tileSet.toTile();
		// var tile = hxd.Res.img.gameoverScreen.toTile();
		// var bgImage = new Bitmap(tile, camera);
	}

	public function init() {
		dispose();
		mds = new MapDataStorage(hxd.Res.map);
		sandTiledGroup = new TileGroup(tileImage, camera);
		for (i in 0...4) {
			var unit = new FireUnit(camera);
			units.push(unit);
			unit.position.x = Std.random(160);
			unit.position.y = Std.random(144);
		}

		bushTiledGroup = new TileGroup(tileImage, camera);
		objectsTiledGroup = new TileGroup(tileImage, camera);
		bushTiledGroup.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
		objectsTiledGroup.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);

		drawMap();
		// var fireUnit:FireUnit = new FireUnit(camera);
		// fireUnit.position = new Point(40, 40);
		// units.push(fireUnit);

		interaction = new Interactive(Globals.STAGE_WIDTH, Globals.STAGE_HEIGHT, this);
		interaction.onMove = function(event:hxd.Event) {
			camera.viewX = event.relX;
			camera.viewY = event.relY;
		}
		interaction.cursor = Cursor.Default;
		ps = new ParticleSystem(camera);
	}

	public function drawMap() {
		// make sub tiles from tile
		var tiles = [
			for (y in 0...Std.int(tileImage.height / mds.tileHeight))
				for (x in 0...Std.int(tileImage.width / mds.tileWidth))
					tileImage.sub(x * mds.tileWidth, y * mds.tileHeight, mds.tileWidth, mds.tileHeight)
		];

		for (y in 0...mds.mapHeight) {
			for (x in 0...mds.mapWidth) {
				var tid = mds.getTileId(x, y, 0);
				if (tid != 0)
					sandTiledGroup.add(x * mds.tileWidth, y * mds.tileHeight, tiles[tid - 1]);
				var tid = mds.getTileId(x, y, 1);
				if (tid != 0)
					bushTiledGroup.add(x * mds.tileWidth, y * mds.tileHeight, tiles[tid - 1]);
			}
		}

		var objects = mds.getObjects();
		
		for (obj in objects) {
			sandTiledGroup.add(obj.x, obj.y - obj.height, tiles[obj.gid - 1]);
		}
		
	}

	public function update(dt:Float) {
		for (unit in units) {
			if (unit != null) {
				// unit.position.x += 0.1;
				unit.update(dt);
				Game.uiManager.hudScreen.setScore(Std.int(unit.position.x));
				// ps.addParticle(ParticleHelper.fontan(Std.int(unit.position.x + 2), Std.int(unit.position.y), Globals.COLOR_SET.Como));
				if (unit.position.x > Globals.STAGE_WIDTH) {
					unit.position.x = 0;
					unit.position.y = Std.random(144);
				}
			}
		}
		if (ps != null) {
			ps.update(dt);
		}

		camera.update(dt);
	}

	public function dispose() {
		for (unit in units) {
			unit.remove();
			unit = null;
		}
		units = new Array<BaseUnit>();
		if (ps != null)
			ps.dispose();

		if (interaction != null) {
			interaction.remove();
			interaction = null;
		}
	}
}
