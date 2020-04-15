package ld.data;

import h2d.TileGroup;
import h2d.Tile;
import hxd.res.Resource;

class MapDataStorage {
	public var mapWidth:Int = 0;
	public var mapHeight:Int = 0;
	public var tileWidth:Int = 0;
	public var tileHeight:Int = 0;

	public var tileImage:Tile;

	private var tiledMapData:TiledMapData;
    private var tileSet:TiledMapSet;
    private var tiles:Array<Tile>;

	public function new(mapData:Resource) {
		tileImage = hxd.Res.img.tileSet.toTile();
		parse(mapData);
	}

	private function parse(res:Resource) {
		tiledMapData = haxe.Json.parse(res.entry.getText());
		mapWidth = tiledMapData.width;
		mapHeight = tiledMapData.height;
		tileWidth = tiledMapData.tilewidth;
		tileHeight = tiledMapData.tileheight;
		tileSet = tiledMapData.tilesets[0];
		tiles = [
			for (y in 0...Std.int(tileImage.height / tileHeight))
				for (x in 0...Std.int(tileImage.width / tileWidth))
					tileImage.sub(x * tileWidth, y * tileHeight, tileWidth, tileHeight)
		];
    }
    
    public function getTileById(id:Int):Tile {
		return tiles[id];
    }
    
    public function getTile(x:Int, y:Int, layer:Int = 0):Tile {
		return getTileById(getTileId(x, y, layer));
	}

	public function getTileId(x:Int, y:Int, layer:Int = 0):Int {
		return tiledMapData.layers[layer].data[x + y * mapWidth];
	}

	public function getObjects(layer:Int = 2):Array<MapObject> {
		return tiledMapData.layers[layer].objects;
	}

	// public function getObjectById(id:Int, layer:Int = 2):MapObject {
	//     return  tiledMapData.layers[layer].objects;
	// }

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
