package swagEngine.yoloController.levelSwag.customSwag;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.tiled.FlxTiledMap;
import openfl.tiled.Layer;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import flixel.FlxBasic;
import flixel.FlxObject;
import openfl.tiled.TiledObjectGroup;
import openfl.tiled.TiledMap;

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
	
	public function new(map:String, wantedLayers:Array<String>, wantedObjects:Array<String>)
	{
		level = FlxTiledMap.fromAssets("assets/levels/" + map + "/level.tmx");
		
		_map = level._map;
		
		width = level.totalWidth;
		height = level.totalHeight;
		
		bgColor = new FlxSprite(0, 0);
		bgColor.makeGraphic(Std.int(FlxG.stage.stageWidth), Std.int(FlxG.stage.stageHeight), level._map.backgroundColor);
		bgColor.scrollFactor.set(0, 0);
		
		for (i in wantedLayers)
		{
			layers.push(level.getLayerByName(i));
		}
		
		for (i in wantedObjects)
		{
			objects.push(level._map.getObjectGroupByName(i));
		}
	}	
}