package swagEngine.yoloController.levelSwag.customSwag ;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeTilemap;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import haxe.io.Path;
import nape.dynamics.InteractionFilter;
import nape.phys.BodyType;
import nape.phys.Material;
import swagEngine.yoloController.levelSwag.objects.Platform;
import swagEngine.yoloController.playerSwag.PlayerRenderer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class LevelParser extends TiledMap					// BEHOLD MY NON COMMENTED UNREADABLE CODE!
{
	private var loadedLevel:Dynamic;
	private var tilemap:FlxNapeTilemap = new FlxNapeTilemap();
	public var staticTiles:FlxGroup = new FlxGroup();
	public var nointeractionTiles:FlxGroup = new FlxGroup();
	public var waterTiles:FlxGroup = new FlxGroup();
	public var cloudTiles:FlxGroup = new FlxGroup();
	
	public function new(level:Dynamic) 
	{
		loadedLevel = level;
		super(loadedLevel + "level.tmx");
		
		FlxG.camera.setScrollBounds(0, fullWidth, 0, fullHeight);
		trace(fullWidth);
		trace(fullHeight);
		
		loadTiles();
	}
	
	private function loadTiles()
	{
		for (tileLayer in layers)
		{
			var tileSheetName:String = tileLayer.properties.get("tileset");
			var tileSet:TiledTileSet = null;
			tilemap = new FlxNapeTilemap();
			
			for (tileSheet in tilesets)
				if (tileSheet.name == tileSheetName)
				{
					tileSet = tileSheet;
					break;
				}
				
			var imagePath = new Path(tileSet.imageSource);
			var resourcePath = loadedLevel + imagePath.file + "." + imagePath.ext;
			
			if (tileLayer.getEncoding() == "base64")
				tilemap.loadMapFromArray(tileLayer.tileArray, width, height, resourcePath, tileWidth, tileHeight, null, 1, 1, 1);
			else if (tileLayer.getEncoding() == "csv")
				tilemap.loadMapFromCSV(tileLayer.csvData, resourcePath, tileWidth, tileHeight, null, 1, 1, 1);
			
			if (tileLayer.properties.contains("clouds"))
			{
				trace(0);
				cloudTiles.add(tilemap);
			}
			
			if (tileLayer.properties.contains("nointeraction"))
			{
				trace(1);
				nointeractionTiles.add(tilemap);
			}
			if (tileLayer.properties.contains("water"))
			{
				trace(2);
				waterTiles.add(tilemap);
			}
			if (tileLayer.properties.contains("static"))
			{
				trace(3);
				tilemap.body.type = BodyType.STATIC;
				tilemap.setupCollideIndex(1, new Material(0, 0.1, 0, 1, 0.1));
				tilemap.body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
				tilemap.body.space = FlxNapeSpace.space;
				staticTiles.add(tilemap);
			}
		}
	}
	
	public function loadObjects(state:Dynamic)
	{
		for (group in objectGroups) for (object in group.objects) loadObject(object, group, state);
	}
	
	private function loadObject(object:TiledObject, group:TiledObjectGroup, state:Dynamic)
	{
		var x:Float = object.x;
		var y:Float = object.y;
		
		if (object.gid != -1)
		{
			if (object.width == 0) object.width = group.map.getGidOwner(object.gid).tileWidth;
			if (object.height == 0) object.height = group.map.getGidOwner(object.gid).tileHeight;
			x = object.x + object.width / 2;
			y = object.y + object.height / 2;
		}
		
		if (object.gid != -1) y -= group.map.getGidOwner(object.gid).tileHeight;
		
		switch (object.type.toLowerCase())			// STUFF ON THE MAP IS PARSED HERE AND ADDED TO THE LEVEL, MAKE A NEW CASE FOR A NEW TYPE OF OBJECT DO NOT EDIT THESE!!!
		{
			case "platform":
				var tileset = group.map.getGidOwner(object.gid);
				var platform:Platform = null;
				if (object.custom.contains("bottom") && object.custom.contains("top")) platform = new Platform(x, y, loadedLevel + tileset.imageSource, object.custom.get("top"), object.custom.get("bottom"), true);
				else if (object.custom.contains("left") && object.custom.contains("right")) platform = new Platform(x, y, loadedLevel + tileset.imageSource, object.custom.get("left"), object.custom.get("right"), false);
				platform.body.setShapeFilters(new InteractionFilter(1, -1, 0, 0, 0, 0));
				platform.body.type = BodyType.KINEMATIC;
				state.platforms.add(platform);
				
			case "player_start":
				var tileset = group.map.getGidOwner(object.gid);
				var player = new PlayerRenderer(x, y, loadedLevel + tileset.imageSource);
				player.facing = FlxObject.RIGHT;
				state.player = player;
				state.add(player);
				
			case "boundaries":
				var boundaries = new FlxObject(x, y, object.width, object.height);
				state.boundaries.add(boundaries);
				
			case "coin":
				var tileset = group.map.getGidOwner(object.gid);
				var coin = new FlxNapeSprite(x, y, loadedLevel + tileset.imageSource);
				coin.body.type = BodyType.KINEMATIC;
				coin.body.setShapeFilters(new InteractionFilter(0, 0, 0, 0, 0, 0));
				state.coins.add(coin);
				
			case "level_exit":
				var exit = new FlxSprite(x, y);
				exit.makeGraphic(object.width, object.height, 0xff3f3f3f);
				exit.exists = false;
				state.exit = exit;
				state.add(exit);
		}
	}
}