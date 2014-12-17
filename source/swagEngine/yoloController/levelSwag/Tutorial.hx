package swagEngine.yoloController.levelSwag ;

import flixel.addons.nape.FlxNapeSpace;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import swagEngine.interSwag.Interface;
import swagEngine.interSwag.MainMenu;
import swagEngine.yoloController.levelSwag.customSwag.ParseFlxTiledMap;
import flixel.group.FlxGroup;
import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxObject;
import flixel.FlxBasic;
import flixel.group.FlxGroup;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import swagEngine.yoloController.levelSwag.objects.Coin;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Tutorial extends FlxState
{
	private var map:String = "Tutorial";
	private var level:ParseFlxTiledMap;
	private var UI:FlxSpriteGroup;
	private var player:FlxObject;
	private var floor:FlxObject;
	private var coins:FlxGroup = new FlxGroup();

	override public function create():Void
	{
		super.create();
		
		FlxNapeSpace.init();
		//FlxNapeSpace.space.gravity.y = 1000;
		FlxNapeSpace.space.worldLinearDrag = 1;
		FlxNapeSpace.drawDebug = true;
		active = false;
		var wantedLayers:Array<String> = ["Clouds", "Background", "Level", "Foreground"];						// 0 = clouds, 1 = background, 2 = level, 3 = foreground
		var wantedObjects:Array<String> = ["bounds", "player_start", "level_exit", "coins", "platforms"];		// 0 = bounds, 1 = player_start, 2 = level_exit, 3 = coinds, 4 = platforms
		
		level = new ParseFlxTiledMap(map, wantedLayers, wantedObjects);
		
		player = new PlayerRenderer(level.objects[1].objects[0].x + (level.objects[1].objects[0].width / 2), level.objects[1].objects[0].y - (level.objects[1].objects[0].height / 2), "assets/levels/" + map + "/" + level._map.getTilesetByGID(level.objects[1].objects[0].gid).image.source);
		
		add(level.bgColor); 	// SET THE BACKGROUND COLOR
		
		for (i in level.objects[3])
			coins.add(new Coin(i.x, i.y, "assets/levels/" + map + "/" + level._map.getTilesetByGID(i.gid).image.source));
		add(coins);
		
		add(level.layers[0]);	// BACKGROUND AS DEFINED BY WANTEDLAYERS ABOVE
		add(level.layers[1]);	// BACKGROUND AS DEFINED BY WANTEDLAYERS ABOVE
		add(level.layers[2]);	// LEVEL AS DEFINED BY WANTEDLAYERS ABOVE
		add(player);			// PLAYER SHOULD BE ONTOP OF THE LEVEL LAYER
		add(level.layers[3]);	// FOREGROUND AS DEFINED BY WANTEDLAYERS ABOVE
		
		floor = new FlxObject(level.objects[0].objects[0].x, level.objects[0].objects[0].y, level.objects[0].objects[0].width, level.objects[0].objects[0].height);
		add(floor);
		
		// ADD THE INTERFACE
		UI = new Interface();
		add(UI);
		
		// MAKE THE CAMERA FOLLOW THE PLAYER RESTRICTED TO THE TOTAL MAP SIZE
		FlxG.camera.setScrollBounds(0, level.width, 0, level.height);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, level.width, level.height);
		
		active = true;
	}
	
	private function getCoin(coin:FlxObject, player:FlxObject)
	{		
		coin.kill();
		//if (coins.countLiving() == 0) exit.exists = true;
	}
	
	override public function update(elapsed:Float):Void
	{
		if (player.overlaps(coins))
		{
			trace("overlaps!");
		}
		
		FlxG.overlap(coins, player, getCoin);
		
		if (FlxG.overlap(floor, player)) FlxG.resetState();
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		if (!player.isOnScreen()) FlxG.resetState();
		
		super.update(FlxG.elapsed);
	}
}