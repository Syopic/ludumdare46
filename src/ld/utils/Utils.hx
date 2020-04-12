package ld.utils;

class Utils {
	public static function uid():String {
		var result = "";

		for (j in 0...10) {
			if (j == 8) {
				result += "-";
			}
			result += StringTools.hex(Math.floor(Math.random() * 16));
		}

		return result.toUpperCase();
	}

	public static function safeDestroy(obj:Dynamic, ?destroy:Bool = false):Bool {
		if (obj == null)
			return false;

		var objs:Array<Dynamic> = Std.is(obj, Array) ? obj : [obj];

		for (o in objs) {
			if (o == null)
				continue;
			if (destroy)
				try {
					o.destroy();
				} catch (e:Dynamic) {
					trace("[Error on object: " + o + ", {" + e + "}");
				}

			var parent = null;
			try {
				parent = o.parent;
			} catch (e:Dynamic) {
				// trace(e);
			}
			if (parent != null)
				parent.removeChild(o);
		}
		return true;
	}
}
