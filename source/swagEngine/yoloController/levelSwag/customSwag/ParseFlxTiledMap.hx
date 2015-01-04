package swagEngine.yoloController.levelSwag.customSwag;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.tiled.*;
import openfl.tiled.display.FlxEntityRenderer;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeTilemap;
import nape.phys.Material;
import nape.dynamics.InteractionFilter;
import flixel.group.FlxGroup;

/**
* ...
* @author Sjoer van der Ploeg
*/

class ParseFlxTiledMap extends FlxTiledMap
{
	public var objects:Array<TiledObjectGroup> = new Array();
	public var bgColor:FlxSprite;
	
	public function new(map:String, wantedObjects:Array<String>)
	{
		super(TiledMap.fromAssetsWithAlternativeRenderer("assets/levels/" + map + "/level.tmx", new FlxEntityRenderer(), false));
		
		bgColor = new FlxSprite(0, 0);
		bgColor.makeGraphic(Std.int(FlxG.stage.stageWidth), Std.int(FlxG.stage.stageHeight), _map.backgroundColor);
		bgColor.scrollFactor.set(0, 0);
		
		for (o in wantedObjects)
		{
			objects.push(_map.getObjectGroupByName(o));
		}
	}
	
	public function napeMap(layer:String, collide:Bool):FlxNapeTilemap
	{
		var napeLayer = new FlxNapeTilemap();
		
			for (t in _map.getLayerByName(layer).tiles)
				if (t.gid != 0)
				{
					napeLayer.loadMapFromCSV(_map.getLayerByName(layer).toCSV(), _map.getTilesetByGID(t.gid).image.texture, t.width, t.height, OFF, 1, 1, 1);
					napeLayer.alpha = _map.getLayerByName(layer).opacity;
					napeLayer.setupCollideIndex(1, new Material(0, 0, 0, 1, 0));
					
					if (collide) napeLayer.body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
					else napeLayer.body.setShapeFilters(new InteractionFilter(0, 0, 0, 0, 0, 0));
					
					break;
				}
				
			napeLayer.body.space = FlxNapeSpace.space;
			return napeLayer;
	}
}