package ld.utils.particles;

import ld.utils.particles.ParticleSystem.ParticleOptions;

class ParticleHelper {
	public static function fontan(x:Int, y:Int, color:Int) {
		var options:ParticleOptions = {
			x: x,
			y: y,
			friction: 0,
			velocity: 0.4,
			lifetime: 0.5,
			gravity: 10,
			color: color,
			forceX: 0,
			forceY: -1,
			forceRandomRange: 1,
			lifetimeRandomRange: 0.3
		}
		return options;
	}
}
