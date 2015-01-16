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
		
		add(level.layers[0]);		// Background2
		add(level.layers[1]);		// Background1
		add(level.layers[2]);		// Foreground
		add(level.layers[3]);		// Level
		add(level.layers[4]);		// WaterLayer
		
		var _player = level._map.getObjectByName("player_start", level._map.getObjectGroupByName("Player"));
			 player = new PlayerRenderer(_player.x, _player.y);
		add(player);
		
		FlxG.camera.setScrollBounds(0, level.totalWidth, 0, level.totalHeight);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, level.totalWidth, level.totalHeight);
	}
	
	private function getCoin(coin:FlxObject, player:FlxObject)
	{		
		coin.kill();
		if (coins.countLiving() == 0) exit.exists = true;
	}

	override public function update(e)
	{
		if (FlxG.overlap(boundaries, player)) FlxG.resetState();
		if (FlxG.overlap(exit, player)) FlxG.resetState();
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		
		super.update(e);
	}
}