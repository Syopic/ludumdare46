package ld.sound;

import ld.view.base.GameObject;
import hxd.res.Sound;
import hxd.snd.Channel;

class SoundManager {
	var sounds:Map<String, Sound> = new Map<String, Sound>();
	var channels:Map<String, Channel> = new Map<String, Channel>();

	public function new() {
		init();
	}

	private function init() {
		#if js
		if (hxd.res.Sound.supportedFormat(Mp3)) {
			sounds["track1"] = hxd.Res.sound.music.track1;
			sounds["test"] = hxd.Res.sound.sfx.test;
			sounds["t2"] = hxd.Res.sound.sfx.t2;
		}
		#else
		if (hxd.res.Sound.supportedFormat(OggVorbis)) {
			sounds["track1"] = hxd.Res.sound.music.track1;
			sounds["test"] = hxd.Res.sound.sfx.test;
			sounds["t2"] = hxd.Res.sound.sfx.t2;
		}
		#end
	}

	public function playSound(name:String, volume:Float = 1, loop:Bool = false) {
		var sound:Sound = sounds[name];
		if (sound != null) {
			var channel = sound.play(loop);
			channel.volume = volume;

			if (loop) {
				channels[name] = channel;
			}
		}
	}

	public function stopSound(guid:String) {
		if (channels[guid] != null) {
			channels[guid].stop();
			channels.remove(guid);
		}
	}

	var delay:Float = 0;

	public function update(dt:Float) {
		delay -= 1;
		if (delay < 0) {
			delay = 10;
			for (guid in channels.keys()) {
				var channel = channels[guid];
			}
		}
	}
}
