package swagEngine.yoloController.levelSwag ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import swagEngine.interSwag.Interface;
import swagEngine.interSwag.MainMenu;
import swagEngine.yoloController.levelSwag.customSwag.ParseFlxTiledMap;
import swagEngine.yoloController.levelSwag.yoloObjects.*;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import openfl.tiled.FlxLayer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Tutorial extends FlxState
{
	private var map:String = "Tutorial";
	private var level:ParseFlxTiledMap;
	private var UI:Interface;
	private var player:PlayerRenderer = null;
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
		
		level = new ParseFlxTiledMap(map);
		
		solid.add(level.getLayerByName("Level"));
		
		water.add(level.getLayerByName("Water"));
		
		player = new PlayerRenderer(FlxG.width * 0.5, FlxG.height * 0.5, level._map.getTilesetByGID(level.objects[0].objects[0].gid).image.texture);
		
		add(level.bgColor);
		
		// ADD STUFF TO SHOW FROM HERE ON TO THE STATE WITH ADD:
		
		add(level.getLayerByName("Darkwater"));
		add(level.getLayerByName("Moving_water"));
		
		var yolo:FlxLayer = level.getLayerByName("Clouds_back");
			//yolo.forEach(function(tile:FlxTile) { tile.scrollFactor.set(0.1, 0.1); } );
		add(yolo);
		
		add(level.getLayerByName("Clouds_back"));
		
		for (coin in level.objects[2])
			coins.add(new Coin(coin.x, coin.y, "assets/levels/" + map + "/" + level._map.getTilesetByGID(coin.gid).image.source));
		add(coins);
		
		for (platform in level.objects[3])
		{
			if (platform.type == "vertical") platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), true));
			else if (platform.type == "horizontal") platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), false));
		}
		add(platforms);
		
		for (level_exit in level.objects[1])
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
		
		FlxG.camera.setBounds(0, 0, level.totalWidth, level.totalHeight);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, level.totalWidth, level.totalHeight);
		
		player.health = 1000;
		player.setPosition(level.objects[0].objects[0].x, level.objects[0].objects[0].y);
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
	
	override public function update()
	{
		if (player.overlaps(water)) player.hurt(10);
		
		FlxG.overlap(coins, player, getCoin);
		FlxG.overlap(exits, player, doExit);
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		if (!player.isOnScreen()) FlxG.resetState();
		
		if (!player.alive) FlxG.resetState();
		UI.health = player.health;
		
		super.update();
	}
}