package swagEngine.yoloController.levelSwag.customSwag;

import flixel.addons.nape.FlxNapeTilemap;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import openfl.tiled.FlxTiledMap;
import openfl.tiled.TiledMap;
import openfl.tiled.TiledObjectGroup;
import swagEngine.yoloController.playerSwag.PlayerRenderer;

/**
* ...
* @author Sjoer van der Ploeg
*/

class ParseFlxTiledMap
{
	private var level:FlxTiledMap;
	public var player:PlayerRenderer;
	public var exit:FlxSprite;
	public var layers:Array<FlxBasic> = new Array();
	public var objects:Array<TiledObjectGroup> = new Array();
	public var width:Float = 0;
	public var height:Float = 0;
	public var bgColor:FlxSprite;
	public var _map:TiledMap;
	public var yolo:FlxNapeTilemap;
	
	public function new(map:String, wantedLayers:Array<String>, wantedObjects:Array<String>, ?levelLayer:String = null)
	{
		this.level = FlxTiledMap.fromAssets("assets/levels/" + map + "/level.tmx");
		
		this._map = level._map;
		
		this.width = level.totalWidth;
		this.height = level.totalHeight;
		
		this.bgColor = new FlxSprite(0, 0);
		this.bgColor.makeGraphic(Std.int(FlxG.stage.stageWidth), Std.int(FlxG.stage.stageHeight), level._map.backgroundColor);
		this.bgColor.scrollFactor.set(0, 0);
		
		for (i in wantedLayers)
		{
			this.layers.push(level.getLayerByName(i));
		}
		
		for (i in wantedObjects)
		{
			this.objects.push(level._map.getObjectGroupByName(i));
		}
		
		// >> WHY DOES THIS NOT WORK?
		yolo.loadMapFromCSV(this.level.getLayerByName(levelLayer)._layer.toCSV(), ("assets/levels/" + map + "/level.png"));
	}	
}