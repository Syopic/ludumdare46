package ld.utils.particles;

import h2d.Tile;
import ld.utils.particles.ParticleSystem.ParticleOptions;
import h2d.col.Point;
import h2d.SpriteBatch.BatchElement;
import h2d.Object;
import ld.data.Globals;

class Particle extends BatchElement {
	public var position:Point;
	public var force:Point;
	public var friction : Float = 1.;
	public var gravity : Float = 0.;
	public var velocity:Float = 1;
	public var lifetime:Float = 5;
	public var color:Int;
	public var currentLifeTime:Float = 0;
	public var options:ParticleOptions;
	public var realX:Float;
	public var realY:Float;
	public var collission:Bool = true;
	

	public function new(options:ParticleOptions) {
		super(Tile.fromColor(0x000000, 1, 1));

		this.options = options;

		position = new Point(options.x, options.y);
		this.realX = position.x;
		this.realY = position.y;
		force = new Point(options.forceX, options.forceY);

		force.x += (options.forceRandomRange * Math.random() - options.forceRandomRange / 2);
		force.y += (options.forceRandomRange * Math.random() - options.forceRandomRange / 2);

		friction = options.friction <= 1 ? options.friction : 0;
		velocity = options.velocity != null ? options.velocity : 1;
		gravity = options.gravity != null ? options.gravity : 0;

		lifetime = options.lifetime + Math.random() * options.lifetimeRandomRange;
		color = options.color;
	}

	override public function update(dt:Float) {

		this.realX +=force.x;
		this.realY +=force.y;
		
		velocity *= (1 - friction);
		force.y += (gravity / 10) * dt;

		this.x = Math.round(this.realX);
		this.y = Math.round(this.realY);

		currentLifeTime += dt;

		return true;
	}
}
  