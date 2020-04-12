package ld.utils.particles;

import h2d.Tile;
import h2d.SpriteBatch;
import h2d.Object;
import ld.utils.Utils;

class ParticleSystem extends h2d.Object {
	public var particlesCount(get, null):Int;

	var emitters:Array<ParticleEmitter>;
	var particles:Array<Particle>;
	var sbMap:Map<Int, SpriteBatch>;
	var container:Object;

	public function new(parent) {
		super(parent);
		sbMap = new Map<Int, SpriteBatch>();
		emitters = new Array<ParticleEmitter>();
		particles = new Array<Particle>();
		container = new Object(this);
	}

	public function addEmitter(eOptions:EmitterOptions, pOptions:ParticleOptions):ParticleEmitter {
		var e = new ParticleEmitter(this, eOptions, pOptions);
		emitters.push(e);
		return e;
	}

	public function removeEmitter(e:ParticleEmitter) {
		emitters.remove(e);
		Utils.safeDestroy(e, false);
	}

	public function addParticle(options:ParticleOptions) {
		var p = new Particle(options);
		var sb:SpriteBatch = sbMap[options.color];
		if (sb == null) {
			sb = new SpriteBatch(Tile.fromColor(options.color, 1, 1), container);
			sbMap[options.color] = sb;
		}
		sb.add(p);
		particles.push(p);
	}

	public function get_particlesCount():Int {
		return particles.length;
	}

	public function removeAll() {
		for (p in particles) {
			if (p != null) {
				particles.remove(p);
				p.remove();
			}
		}
	}

	public function update(dt:Float) {
		for (e in emitters) {
			e.update(dt);
			if (e.currentDuration > e.duration) {
				removeEmitter(e);
			}
		}

		for (p in particles) {
			if (p != null) {
				p.update(dt);
				if (p.currentLifeTime > p.lifetime) {
					particles.remove(p);
					p.remove();
				}
			}
		}
	}

	public function dispose() {
		removeAll();
		container.removeChildren();
		sbMap = new Map<Int, SpriteBatch>();
		emitters = new Array<ParticleEmitter>();
		particles = new Array<Particle>();
	}
}

typedef ParticleOptions = {
	@:optional var x:Float;
	@:optional var y:Float;
	@:optional var forceX:Float;
	@:optional var forceY:Float;
	@:optional var velocity:Float;
	@:optional var gravity:Float;
	@:optional var friction:Float;
	@:optional var lifetime:Float;
	@:optional var color:Int;
	@:optional var velocityRandomRange:Float;
	@:optional var forceRandomRange:Float;
	@:optional var lifetimeRandomRange:Float;
	@:optional var collision:Bool;
}

typedef EmitterOptions = {
	@:optional var x:Float;
	@:optional var y:Float;
	@:optional var rate:Float;
	@:optional var duration:Float;
	@:optional var positionRange:Float;
	@:optional var rateRange:Float;
}
