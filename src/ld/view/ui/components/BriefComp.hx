package ld.view.ui.components;

import hxd.Cursor;
import h2d.Interactive;
import h3d.Vector;
import hxd.Res;
import h2d.Text;
import h2d.filter.Glow;
import h2d.Bitmap;
import h2d.Tile;
import ld.data.Globals;
import h2d.Object;

class BriefComp extends Object {
	var bg:Bitmap;
	var nextButton:Bitmap;
	var heroImg:Bitmap;
	var messageTF:Text;
	var cursorPosition:Float = 0;
	var currentMessage:Int = -1;
	var messages:Array<BriefMessage>;
	var nextButtonDelay:Int = 20;

	public function new(?parent:Object) {
		super(parent);
		messages = new Array<BriefMessage>();
		var tile = Tile.fromColor(Globals.COLOR_SET.SpringRain, Globals.STAGE_WIDTH, 40);
		bg = new Bitmap(tile, this);
		bg.y = Globals.STAGE_HEIGHT - 40;
		bg.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
		messageTF = new Text(Res.font.gb.toFont(), this);

		messageTF.textColor = Globals.COLOR_SET.TimberGreen;
		messageTF.maxWidth = Globals.STAGE_WIDTH - 12;
		messageTF.textAlign = Left;
		messageTF.setPosition(6, Globals.STAGE_HEIGHT - 36);

		nextButton = new Bitmap(Game.controller.mapDataStorage.getTileById(239), this);
		nextButton.setPosition(Globals.STAGE_WIDTH - 12, Globals.STAGE_HEIGHT - 10);
		nextButton.visible = false;
		var interaction = new Interactive(Globals.STAGE_WIDTH, 40, this);
		interaction.y = Globals.STAGE_HEIGHT - 40;
		interaction.cursor = Cursor.Button;
		interaction.onOver = function(event:hxd.Event) {}

		interaction.onOut = function(event:hxd.Event) {}
		interaction.onClick = function(event:hxd.Event) {
			next();
		}
	}

	public function addMessage(message:BriefMessage) {
		messages.push(message);
	}

	public function start() {
		cursorPosition = 0;
		currentMessage = 0;
		setImage();
	}

	function setImage() {
		var message = messages[currentMessage];
		if (heroImg != null)
			heroImg.remove();
		heroImg = null;

		heroImg = new Bitmap(message.img, this);
		heroImg.y = bg.y - message.img.height;
		if (!message.isLeft) {
			heroImg.x = Globals.STAGE_WIDTH - message.img.width;
		}
	}

	public function next() {
		if (currentMessage < messages.length - 1) {
			currentMessage++;
			cursorPosition = 0;
			messageTF.text = "";
			setImage();
		} else {
			Game.uiManager.hideBrief();
		}
	}

	public function update(dt:Float) {
		if (currentMessage >= 0) {
			if (messages[currentMessage].text.length > cursorPosition) {
				cursorPosition += dt * 10;
				nextButton.visible = false;
			} else {
				nextButton.visible = true;
				if (currentMessage >= messages.length - 1) {
					nextButton.rotation = -Math.PI / 2;
					nextButton.y = Globals.STAGE_HEIGHT - 4;
					if (--nextButtonDelay < 0) {
						nextButtonDelay = 20;
						if (nextButton.x == Globals.STAGE_WIDTH - 12)
							nextButton.x = Globals.STAGE_WIDTH - 11;
						else
							nextButton.x = Globals.STAGE_WIDTH - 12;
					}
				} else {
					if (--nextButtonDelay < 0) {
						nextButtonDelay = 20;
						if (nextButton.y == Globals.STAGE_HEIGHT - 10)
							nextButton.y = Globals.STAGE_HEIGHT - 9;
						else
							nextButton.y = Globals.STAGE_HEIGHT - 10;
					}
				}
			}
			if (messageTF.text.length < cursorPosition - 1) {
				Game.soundManager.playSound(Globals.SFX_SET.UIHover, 0.5);
				messageTF.text = messages[currentMessage].text.substr(0, Std.int(cursorPosition));
			}
		}
	}

	public function dispose() {}
}

typedef BriefMessage = {
	text:String,
	img:Tile,
	isLeft:Bool
}
