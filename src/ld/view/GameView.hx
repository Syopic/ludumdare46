package ld.view;

import ld.utils.particles.ParticleSystem;
import ld.utils.particles.ParticleHelper;
import h2d.Tile;
import ld.data.Globals;
import h2d.Bitmap;
import h2d.Object;
import ld.view.unit.BaseUnit;

class GameView extends Object {

	var container:Object;
	var unit:BaseUnit;
	var ps:ParticleSystem;

	public function new(parent:Object) {
		super(parent);
		container = new Object(this);
		ps = new ParticleSystem(container);
	}

	public function init() {
		dispose();
		unit = new BaseUnit(container);
		unit.position.x = Std.random(160);
		unit.position.y = Std.random(144);
	}

	public function update(dt:Float) {
		if (unit != null) {
			// unit.position.x += 1;
			unit.update(dt);
			ps.addParticle(ParticleHelper.fontan(Std.int(unit.position.x + 2), Std.int(unit.position.y), Globals.COLOR_SET.Como));
			if (unit.position.x > Globals.STAGE_WIDTH) unit.position.x = 0;
		}
		if (ps != null) {
			ps.update(dt);
		}
	}

	public function dispose() {
		// container.removeChildren();
		if (unit != null) {
			unit.remove();
			unit = null;
		}
		if (ps != null)
			ps.dispose();
	}
}
