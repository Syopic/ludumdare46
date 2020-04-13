package ld.utils.console;

import h2d.Console;

class CustomConsole extends Console {
	public function logInLine(text:String, ?color) {
		if (color == null)
			color = tf.textColor;
		var oldH = logTxt.textHeight;
		logTxt.text = logTxt.text + '<font color="#${StringTools.hex(color & 0xFFFFFF, 6)}">${StringTools.htmlEscape(text)}</font>';
		if (logDY != 0)
			logDY += logTxt.textHeight - oldH;
		logTxt.alpha = 1;
		logTxt.visible = true;
		lastLogTime = haxe.Timer.stamp();
	}
}
