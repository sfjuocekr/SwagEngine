package swagEngine.yoloController.levelSwag ;

import flixel.addons.nape.FlxNapeSpace;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import haxe.Timer;
import swagEngine.interSwag.Interface;
import swagEngine.interSwag.MainMenu;
import swagEngine.yoloController.levelSwag.customSwag.ParseFlxTiledMap;
import flixel.group.FlxGroup;
import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxObject;
import flixel.FlxBasic;
import flixel.group.FlxGroup;
import swagEngine.yoloController.levelSwag.objects.animator.Dove;
import swagEngine.yoloController.levelSwag.objects.animator.Rabbit;
import swagEngine.yoloController.levelSwag.objects.Platform;
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
	private var player:PlayerRenderer;
	private var floor:FlxGroup = new FlxGroup();
	private var coins:FlxGroup = new FlxGroup();
	private var platforms:FlxGroup = new FlxGroup();
	private var exits:FlxGroup = new FlxGroup();
	private var water:FlxGroup = new FlxGroup();

	override public function create():Void
	{
		super.create();
		
		FlxNapeSpace.init();
		//FlxNapeSpace.space.gravity.y = 1000;
		FlxNapeSpace.space.worldLinearDrag = 1;
		FlxNapeSpace.drawDebug = true;
		
		var wantedLayers:Array<String> = ["Clouds", "Background", "Level", "Foreground", "Water"];						// 0 = clouds, 1 = background, 2 = level, 3 = foreground
		var wantedObjects:Array<String> = ["bounds", "player_start", "level_exit", "coins", "platforms"];		// 0 = bounds, 1 = player_start, 2 = level_exit, 3 = coinds, 4 = platforms
		
		level = new ParseFlxTiledMap(map, wantedLayers, wantedObjects);
		player = new PlayerRenderer(FlxG.width * 0.5, FlxG.height * 0.5, "assets/levels/" + map + "/" + level._map.getTilesetByGID(level.objects[1].objects[0].gid).image.source);
		
		add(level.bgColor); 	// SET THE BACKGROUND COLOR
				
		for (coin in level.objects[3])
			coins.add(new Coin(coin.x, coin.y, "assets/levels/" + map + "/" + level._map.getTilesetByGID(coin.gid).image.source));
		add(coins);
		
		for (platform in level.objects[4])
		{
			if (platform.properties.get("top") != null && platform.properties.get("bottom") != null) platforms.add(new Platform(platform.x, platform.y, "assets/levels/" + map + "/" + level._map.getTilesetByGID(platform.gid).image.source, platform.properties.get("top"), platform.properties.get("bottom"), true));
			else if (platform.properties.get("left") != null && platform.properties.get("right") != null) platforms.add(new Platform(platform.x, platform.y, "assets/levels/" + map + "/" + level._map.getTilesetByGID(platform.gid).image.source, platform.properties.get("left"), platform.properties.get("right"), false));
		}
		add(platforms);
		
		for (level_exit in level.objects[2])
		{
			var exit = new FlxSprite(level_exit.x, level_exit.y);
				exit.makeGraphic(level_exit.width, level_exit.height, 0xff3f3f3f);
				exit.exists = false;
			exits.add(exit);
		}
		add(exits);
		
		add(level.layers[0]);	// BACKGROUND AS DEFINED BY WANTEDLAYERS ABOVE
		add(level.layers[1]);	// BACKGROUND AS DEFINED BY WANTEDLAYERS ABOVE
		
		level.layers[2].set_active(true);
		add(level.layers[2]);	// LEVEL AS DEFINED BY WANTEDLAYERS ABOVE
		
		add(player);			// PLAYER SHOULD BE ONTOP OF THE LEVEL LAYER
		add(level.layers[3]);	// FOREGROUND AS DEFINED BY WANTEDLAYERS ABOVE
		
		level.layers[4].set_active(true);
		add(level.layers[4]);	// WATER AS DEFINED BY WANTEDLAYERS ABOVE
		
		floor.add(new FlxObject(level.objects[0].objects[0].x, level.objects[0].objects[0].y, level.objects[0].objects[0].width, level.objects[0].objects[0].height));
			var debug = new FlxSprite(level.objects[0].objects[0].x, level.objects[0].objects[0].y);
				debug.makeGraphic(level.objects[0].objects[0].width, level.objects[0].objects[0].height, 0xff3f3f3f);
			floor.add(debug);
		add(floor);
		
		// ADD THE INTERFACE
		UI = new Interface();
		add(UI);
		
		// MAKE THE CAMERA FOLLOW THE PLAYER RESTRICTED TO THE TOTAL MAP SIZE
		
		add(new Rabbit(128,128));
		add(new Dove(0,0));
		
		FlxG.camera.setScrollBounds(0, level.width, 0, level.height);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, level.width, level.height);
		
		player.health = 1000;
		player.setPosition(level.objects[1].objects[0].x + (level.objects[1].objects[0].width * 0.5), level.objects[1].objects[0].y - (level.objects[1].objects[0].height * 0.5));
	}
	
	private function getCoin(coin:FlxObject, player:FlxObject)
	{	
		coin.kill();
		if (coins.countLiving() == 0) exits.members[0].exists = true;
	}
	
	private function hitWater(a:FlxObject, b:FlxObject)
	{	
		// player.hurt(1);					// WATER DOES DAMAGE?
		// test overlap in some funky way
	}
	
	override public function update(elapsed:Float):Void
	{
		FlxG.overlap(level.layers[4], player, hitWater);
		FlxG.overlap(coins, player, getCoin);
				
		if (FlxG.overlap(floor, player)) FlxG.resetState();
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		if (!player.isOnScreen()) FlxG.resetState();
		
		if (!player.alive) FlxG.resetState();
		UI.health = player.health;
		
		super.update(FlxG.elapsed);
	}
}