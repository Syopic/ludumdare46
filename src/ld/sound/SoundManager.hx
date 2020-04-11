package ld.sound;

import ld.data.Globals;
import hxd.res.Sound;
import hxd.snd.Channel;

class SoundManager {
	var sounds:Map<String, Sound> = new Map<String, Sound>();
	var channels:Map<String, Channel> = new Map<String, Channel>();
	var isMute:Bool = false;

	public function new() {
		init();
	}

	private function init() {
		if (hxd.res.Sound.supportedFormat(Mp3)) {
			// music
			sounds[Globals.MUSIC_SET.TitleTheme] = hxd.Res.sound.music.track1;
			// sfx
			sounds[Globals.SFX_SET.UIHover] = hxd.Res.sound.sfx.uiHov;
			sounds[Globals.SFX_SET.Test1] = hxd.Res.sound.sfx.test;
			sounds[Globals.SFX_SET.Test2] = hxd.Res.sound.sfx.t2;
		}
	}

	public function playSound(name:String, volume:Float = 1, loop:Bool = false) {
		var sound:Sound = sounds[name];
		if (sound != null) {
			var channel = sound.play(loop);
			channel.mute = this.isMute;
			channel.volume = volume;
			channels[name] = channel;
		}
	}

	public function stopSound(name:String) {
		if (channels[name] != null) {
			channels[name].stop();
			channels.remove(name);
		}
	}

	public function pause(isPause:Bool = true) {
		for (c in channels) {
			c.pause = isPause;
		}
	}

	public function mute(isMute:Bool = true) {
		this.isMute = isMute;
		for (c in channels) {
			c.mute = isMute;
		}
	}

	public function update(dt:Float) {
	}
}
