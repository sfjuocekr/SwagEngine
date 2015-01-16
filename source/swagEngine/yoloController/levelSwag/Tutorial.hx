package swagEngine.yoloController.levelSwag ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import openfl.tiled.FlxLayer;
import openfl.tiled.FlxTiledMap;
import swagEngine.interSwag.Interface;
import swagEngine.interSwag.MainMenu;
import swagEngine.yoloController.levelSwag.yoloObjects.*;
import swagEngine.yoloController.playerSwag.PlayerRenderer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Tutorial extends FlxState
{
	private var map:String = "Tutorial";
	private var level:FlxTiledMap;
	private var UI:Interface;
	private var player:PlayerRenderer;
	private var bounds:FlxGroup = new FlxGroup();
	private var coins:FlxGroup = new FlxGroup();
	private var platforms:FlxGroup = new FlxGroup();
	private var exits:FlxGroup = new FlxGroup();
	private var solid:FlxGroup = new FlxGroup();
	private var water:FlxGroup = new FlxGroup();
	private var enemies:FlxGroup = new FlxGroup();
	
	override public function create()
	{
		super.create();
		
		level = FlxTiledMap.fromAssets("assets/levels/" + map + "/level.tmx");
		
		solid.add(level.getLayerByName("Level"));
		
		water.add(level.getLayerByName("Water"));
		
		var _player = level._map.getObjectByName("player_start", level._map.getObjectGroupByName("Player"));
			 player = new PlayerRenderer(_player.x, _player.y);
		
		//add(level.bgColor);
		
		// ADD STUFF TO SHOW FROM HERE ON TO THE STATE WITH ADD:
		
		add(level.getLayerByName("Darkwater"));
		add(level.getLayerByName("Moving_water"));
		
		var yolo:FlxLayer = level.getLayerByName("Clouds_back");
			//yolo.forEach(function(tile:FlxTile) { tile.scrollFactor.set(0.1, 0.1); } );
		add(yolo);
		
		add(level.getLayerByName("Clouds_back"));
		
		for (coin in level._map.getObjectGroupByName("coins").objects)
			coins.add(new Coin(coin.x, coin.y, level._map.getTilesetByGID(coin.gid).image.texture, coin.type));
		add(coins);
		
		for (platform in level._map.getObjectGroupByName("platforms").objects)
		{
			if (platform.type == "vertical") platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), true));
			else if (platform.type == "horizontal") platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), false));
		}
		add(platforms);
		
		for (level_exit in level._map.getObjectGroupByName("level_exit").objects)
		{
			var exit = new FlxSprite(level_exit.x - level_exit.width * 0.5, level_exit.y + level_exit.height * 0.5);
				exit.makeGraphic(level_exit.width, level_exit.height, 0xff3f3f3f);
				exit.exists = false;
			exits.add(exit);
		}
		add(exits);
		
		//level.getLayerByName("Clouds_front").forEach(function(tile:FlxTile) { tile.scrollFactor.set(0.2, 0.2); } );
		add(level.getLayerByName("Clouds_front"));
		
		add(level.getLayerByName("Background"));
		add(solid);
		add(player);
		add(level.getLayerByName("Foreground"));
		add(water);
		
		UI = new Interface();
		add(UI);
		
		//enemies.add(new Enemy(128, 128, "bird"));
		//enemies.add(new Enemy(256, 256, "rabbit"));
		add(enemies);
		
		FlxG.camera.setScrollBounds(0, level.totalWidth, 0, level.totalHeight);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, level.totalWidth, level.totalHeight);
		
		player.health = 1000;
	}
	
	private function getCoin(coin:FlxObject, player:FlxObject)
	{	
		coin.destroy();
		if (coins.countLiving() == 0) exits.members[0].exists = true;
	}
	
	private function doExit(exit:FlxObject, player:FlxObject)
	{	
		if (exit.exists) FlxG.resetState();
	}
	
	override public function update(e)
	{
		if (player.overlaps(water)) player.hurt(10);
		
		FlxG.overlap(coins, player, getCoin);
		FlxG.overlap(exits, player, doExit);
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		if (!player.isOnScreen()) FlxG.resetState();
		
		if (!player.alive) FlxG.resetState();
		UI.health = player.health;
		
		super.update(e);
	}
}