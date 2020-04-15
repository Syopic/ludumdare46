package ld.data;

import h2d.TileGroup;
import h2d.Tile;
import hxd.res.Resource;

class MapDataStorage { 

    public var mapWidth:Int = 0;
    public var mapHeight:Int = 0;
    public var tileWidth:Int = 0;
    public var tileHeight:Int = 0;

    private var tiledMapData:TiledMapData;
    private var tileSet:TiledMapSet;

    public function new(mapData:Resource) {
		parse(mapData);
    }
    
    private function parse(res:Resource) {
        tiledMapData = haxe.Json.parse(res.entry.getText());
        mapWidth = tiledMapData.width;
        mapHeight = tiledMapData.height;
        tileWidth = tiledMapData.tilewidth;
        tileHeight = tiledMapData.tileheight;
        tileSet = tiledMapData.tilesets[0];
    }

    public function getTileId(x:Int, y:Int, layer:Int = 0):Int {
        return  tiledMapData.layers[layer].data[x + y * mapWidth];
    }
    
    public function getTileItem(x:Int, y:Int):TileItem {
        var tid = tiledMapData.layers[0].data[x + y * mapWidth];
        return tileSet.tiles[tid - 1];
    }
}


typedef TiledMapData = {
	var layers:Array<TiledMapLayer>;
	var tilesets:Array<TiledMapSet>;
	var tilewidth:Int;
	var tileheight:Int;
	var width:Int;
	var height:Int;
}

typedef TiledMapLayer = {
	var data:Array<Int>;
	var name:String;
	var type:String;
	var image:String;
	var opacity:Float;
	var offsetx:Int;
	var offsety:Int;
	var x:Int;
	var y:Int;
	var objects:Array<MapObject>;
}

typedef MapObject = {
	@:optional var gid:Int;
	@:optional var id:Int;
	@:optional var x:Int;
	@:optional var y:Int;
	@:optional var rotation:Float;
	@:optional var name:String;
	@:optional var type:String;
	@:optional var width:Int;
	@:optional var height:Int;
	@:optional var properties:Array<ObjectProperty>;
}

typedef TileItem = {
	id:Int,
	type:String,
	properties:Array<ObjectProperty>
}

typedef TiledMapSet = {
	var firstgid:Int;
	var name:String;
	var source:String;
	var columns:Int;
	var tilecount:Int;
	var tiles:Array<TileItem>;
}

typedef ObjectProperty = {
	var name:String;
	var type:String;
	var value:Any;
}