package ld.view.ui.components;

import ld.data.Globals;
import h2d.filter.Glow;
import hxd.Cursor;
import h2d.Interactive;
import h2d.Bitmap;
import h2d.Object;


class MuteSoundButton extends Object {
    public function new(parent:Object) {
        super(parent);
        var b1 = new Bitmap(Game.controller.mapDataStorage.getTileById(255), this);
        var b2 = new Bitmap(Game.controller.mapDataStorage.getTileById(254), this);
        
        this.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
    
        b1.visible = !Game.soundManager.isMute;
        b2.visible = Game.soundManager.isMute;

		var interaction = new Interactive(8, 8, this);
		interaction.cursor = Cursor.Button;
		interaction.onOver = function(event:hxd.Event) {
			this.filter = new Glow(Globals.COLOR_SET.White, 1, 0.1);
		}

		interaction.onOut = function(event:hxd.Event) {
            this.filter = new Glow(Globals.COLOR_SET.Aztec, 1, 0.1);
        }
        
        interaction.onClick = function(event:hxd.Event) {
            Game.soundManager.isMute = !Game.soundManager.isMute;
            Game.soundManager.mute(Game.soundManager.isMute);
            b1.visible = !Game.soundManager.isMute;
            b2.visible = Game.soundManager.isMute;
		}
       
    }
    
   
}