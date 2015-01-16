package swagEngine.yoloController.levelSwag ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import swagEngine.interSwag.MainMenu;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import flixel.addons.editors.tiled.TiledMap;
import openfl.tiled.FlxTiledMap;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Sjoer extends FlxState
{
	public var level:FlxTiledMap;
	public var platforms:FlxSpriteGroup = new FlxSpriteGroup();
	public var coins:FlxGroup = new FlxGroup();
	public var exit:FlxSprite;
	public var player:PlayerRenderer;
	public var boundaries:FlxGroup = new FlxGroup();
	
	override public function create():Void
	{
		super.create();
		
		var background:FlxSprite = new FlxSprite(0, 0);
			background.makeGraphic(Std.int(FlxG.stage.stageWidth), Std.int(FlxG.stage.stageHeight), 0xff55b4ff);
			background.scrollFactor.set(0, 0);
		add(background);
		
		level = FlxTiledMap.fromAssets("assets/levels/Sjoer/level.tmx");
		
		FlxG.camera.setBounds(0, 0, level.totalWidth, level.totalHeight);
		
		add(level.layers[0]);		// Background2
		add(level.layers[1]);		// Background1
		add(level.layers[2]);		// Foreground
		add(level.layers[3]);		// Level
		add(level.layers[4]);		// WaterLayer
		
		var playerX = level._map.getObjectGroupByName("Player").objects[0].x + level._map.getObjectGroupByName("Player").objects[0].width * 0.5;
		var playerY = level._map.getObjectGroupByName("Player").objects[0].y - level._map.getObjectGroupByName("Player").objects[0].height * 0.5;
		var playerImage = level._map.getTilesetByGID(level._map.getObjectGroupByName("Player").objects[0].gid).image.source;
		player = new PlayerRenderer(playerX, playerY, "assets/levels/Sjoer/" + playerImage);
		player.facing = FlxObject.RIGHT;
		add(player);
	}
	
	private function getCoin(coin:FlxObject, player:FlxObject)
	{		
		coin.kill();
		if (coins.countLiving() == 0) exit.exists = true;
	}

	override public function update()
	{
		if (FlxG.overlap(boundaries, player)) FlxG.resetState();
		if (FlxG.overlap(exit, player)) FlxG.resetState();
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		
		super.update();
	}
}