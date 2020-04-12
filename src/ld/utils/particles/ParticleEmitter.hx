package ld.utils.particles;

import h2d.col.Point;
import ld.data.Globals;
import ld.utils.particles.ParticleSystem.EmitterOptions;
import ld.utils.particles.ParticleSystem.ParticleOptions;

class ParticleEmitter {
	var ps:ParticleSystem;

	public var position:Point = new Point();
	public var rate:Float = 5;
	public var duration:Float = 5;
	public var positionRange:Float = 1;
	public var currentDuration:Float = 0;

	var currentRate:Float = 0;
	public var options:ParticleOptions;

	public function new(ps:ParticleSystem, eOptions:EmitterOptions, pOtions:ParticleOptions) {
		this.ps = ps;

		this.options = pOtions;
		position = new Point(eOptions.x, eOptions.y);
		rate = eOptions.rate;
		duration = eOptions.duration;
		positionRange = eOptions.positionRange;
	}

	public function update(dt:Float) {
		currentRate += dt / hxd.System.getDefaultFrameRate();
		if (currentRate > 1 / rate) {
			currentRate = 0;
			options.x = position.x + (positionRange * Math.random() - positionRange / 2);
			options.y = position.y + (positionRange * Math.random() - positionRange / 2);
			ps.addParticle(options);
		}
	}
}
