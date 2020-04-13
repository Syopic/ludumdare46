package ld.view;

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

class GameView extends Object {
	var container:Object;
	var unit:BaseUnit;
	var ps:ParticleSystem;
	var camera:Camera;
	var units:Array<BaseUnit> = new Array<BaseUnit>();

	public function new(parent:Object) {
		super(parent);
		var mask:Mask = new Mask(Globals.STAGE_WIDTH, Globals.STAGE_HEIGHT, this);
		camera = new Camera(mask, Globals.STAGE_WIDTH, Globals.STAGE_HEIGHT, Globals.STAGE_WIDTH / 2, Globals.STAGE_HEIGHT / 2);
		// var tile = hxd.Res.img.gameoverScreen.toTile();
		// var bgImage = new Bitmap(tile, camera);
	}
	
	public function init() {
		dispose();
		for (i in 0...10) {
			var unit = new BaseUnit(camera);
			units.push(unit);
			unit.position.x = Std.random(160);
			unit.position.y = Std.random(144);
		}
		

		var interaction = new Interactive(Globals.STAGE_WIDTH, Globals.STAGE_HEIGHT, this);
		interaction.onMove = function(event:hxd.Event) {
			camera.viewX = event.relX;
			camera.viewY = event.relY;
		}
		ps = new ParticleSystem(camera);
	}
	
	public function update(dt:Float) {
		for (unit in units) {
			if (unit != null) {
				unit.position.x += 1;
				unit.update(dt);
				Game.uiManager.hudScreen.setScore(Std.int(unit.position.x));
				ps.addParticle(ParticleHelper.fontan(Std.int(unit.position.x + 2), Std.int(unit.position.y), Globals.COLOR_SET.Como));
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
	}
}
