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

class Tagor extends FlxState
{
	private var map:String = "Tagor";
	private var level:FlxTiledMap;
	private var UI:Interface;
	private var player:PlayerRenderer = null;
	private var solid:FlxLayer;
	private var portals:FlxGroup = new FlxGroup();
	private var cards:FlxGroup = new FlxGroup();
	private var platforms:FlxGroup = new FlxGroup();
	private var exits:FlxGroup = new FlxGroup();
	private var enemies:FlxGroup = new FlxGroup();
	private var colliders:FlxGroup = new FlxGroup();
	
	override public function create()
	{
		super.create();
		
		FlxG.debugger.visible = true;
		
		level = FlxTiledMap.fromAssets("assets/levels/" + map + "/level.tmx");	
		
		add(new FlxSprite(0, 0, level._map.imageLayers[0].image.texture));		// Background_image
		
		for (card in level._map.getObjectGroupByName("Cards").objects)
			cards.add(new Card(card.x, card.y, level._map.getTilesetByGID(card.gid).image.texture));
		add(cards);																// Cards
		
		add(level.getLayerByName("Background"));								// Background
		
		var _level_exit = level._map.getObjectByName("level_exit", level._map.getObjectGroupByName("Exits"));
			exits.add(new Exit(_level_exit.x, _level_exit.y, level._map.getTilesetByGID(_level_exit.gid).image.texture));
		add(exits);																// Exits
		
		// Add portals
		
		var _player = level._map.getObjectByName("player_start", level._map.getObjectGroupByName("Player"));
			 player = new PlayerRenderer(_player.x, _player.y);
		add(player);															// Player
		
		solid = level.getLayerByName("Level");
		solid.setActive(true);
		add(solid);																// Level
			
		for (platform in level._map.getObjectGroupByName("Platforms").objects)
		{
			if (platform.type == "vertical") platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), true));
			else if (platform.type == "horizontal") platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), false));
		}
		add(platforms);															// Platforms
		
		enemies.add(new Enemy(128, 128, "bird", 1, 10, player));
		enemies.add(new Enemy(256, 256, "rabbit"));
		add(enemies);															// Enemies
		
		add(level.getLayerByName("Foreground"));								// Foreground
		
		UI = new Interface();
		add(UI);
		
		FlxG.camera.setScrollBounds(0, level.totalWidth, 0, level.totalHeight);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, level.totalWidth, level.totalHeight);
		
		player.health = 1000;
	}
	
	private function getCard(_card:FlxObject, _player:FlxObject)
	{	
		_card.destroy();
		if (cards.countLiving() == 0) exits.members[0].exists = true;
	}
	
	private function doExit(_exit:FlxObject, _player:FlxObject)
	{	
		if (_exit.exists && FlxG.keys.justPressed.SPACE) FlxG.resetState();
	}
	
	override public function update(e)
	{
		FlxG.collide(player, platforms);
		
		FlxG.overlap(player, solid, FlxObject.separate);
		
		super.update(e);
		
		FlxG.overlap(cards, player, getCard);
		FlxG.overlap(exits, player, doExit);
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		if (!player.isOnScreen()) FlxG.resetState();
		
		if (!player.alive) FlxG.resetState();
		UI.health = player.health;
	}
}