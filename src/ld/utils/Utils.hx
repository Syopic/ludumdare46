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
}
