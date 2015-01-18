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
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Tagor extends FlxState
{
	private var map:String = "Tagor";
	private var level:FlxTiledMap;
	
	private var solid:FlxLayer;
	private var invisible:FlxLayer;
	
	private var UI:Interface;
	private var player:PlayerRenderer;
	
	private var shots:FlxGroup = new FlxGroup();
	private var portals:FlxGroup = new FlxGroup();
	private var cards:FlxGroup = new FlxGroup();
	private var platforms:FlxGroup = new FlxGroup();
	private var exits:FlxGroup = new FlxGroup();
	private var enemies:FlxGroup = new FlxGroup();
	
	private var portaling:Bool = false;
	private var portalTimer:Timer = new Timer(100);
	
	override public function create()
	{
		super.create();
		
		level = FlxTiledMap.fromAssets("assets/levels/" + map + "/level.tmx");	
		
		add(new FlxSprite(0, 0, level._map.imageLayers[0].image.texture));		// Background_image
		
		loadLayers();
		loadObjects();
		
		add(cards);																// Cards
		add(level.getLayerByName("Background"));								// Background
		add(exits);																// Exits
		add(portals);															// Portals
		add(shots);								// Objects the player emits
		add(player);															// Player
		//falling
		add(invisible);															// Invicible
		add(solid);																// Level
		add(platforms);															// Platforms
		add(enemies);															// Enemies
		add(level.getLayerByName("Foreground"));								// Foreground
		
		UI = new Interface(player);
		add(UI);																// Interface
		
		FlxG.camera.setScrollBounds(0, level.totalWidth, 0, level.totalHeight);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, level.totalWidth, level.totalHeight);
		
		player.health = 1000;
		
		shots.maxSize = 8;
		
		for (i in 0...shots.maxSize)
		{
			var shot = new FlxSprite( -8, -8);		// make a bullet class with a timer
				shot.makeGraphic(4, 4);
				shot.exists = false;
			
			shots.add(shot);
		}
	}
	
	private function loadLayers()
	{
		solid = level.getLayerByName("Level");
		solid.setActive(true);
		
		invisible = level.getLayerByName("Level");
		invisible.setActive(true);
	}
	
	private function loadObjects()
	{
		var _player = level._map.getObjectByName("player_start", level._map.getObjectGroupByName("Player"));
			 player = new PlayerRenderer(_player.x, _player.y, shots);
		
		for (card in level._map.getObjectGroupByName("Cards").objects)
			cards.add(new Card(card.x, card.y, level._map.getTilesetByGID(card.gid).image.texture, card.type));
		
		var _level_exit = level._map.getObjectByName("level_exit", level._map.getObjectGroupByName("Exits"));
			exits.add(new Exit(_level_exit.x, _level_exit.y, level._map.getTilesetByGID(_level_exit.gid).image.texture));
			
		for (portal in level._map.getObjectGroupByName("Portals").objects)
			portals.add(new Portal(portal.x, portal.y, level._map.getTilesetByGID(portal.gid).image.texture, portal.name, portal.type));
			
		for (platform in level._map.getObjectGroupByName("Platforms").objects)
		{
			switch (platform.type)
			{
				case "vertical":
					platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), true));
					
				case "horizontal":
					platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), false));
			}
		}
		
		for (enemy in level._map.getObjectGroupByName("Enemies").objects)
		{	
			switch (enemy.name)
			{
				case "bird":
					enemies.add(new Enemy(enemy.x, enemy.y, enemy.rotation, enemy.name, player, enemy.properties.get("min"), enemy.properties.get("max"), enemy.type));
					
				case "rabbit":
					enemies.add(new Enemy(enemy.x, enemy.y, enemy.rotation, enemy.name, player));
			}
		}
	}
	
	private function getCard(_card:Card, _player:FlxObject)
	{
		_card.kill();
		
		player.abilities.cards.collect(_card.type);
		
		if (cards.countLiving() == 0) exits.members[0].exists = true;
	}
	
	private function doExit(_exit:FlxObject, _player:FlxObject)
	{	
		if (_exit.exists && FlxG.keys.justPressed.SPACE) FlxG.resetState();
	}
	
	private function doPortal(_portal:Portal, _player:FlxObject)
	{
		if (FlxG.keys.justPressed.SPACE && !portaling)
		{
			portaling = true;
			
			for (portal in portals.members)
			{
				var temp:Portal = cast(portal, Portal);
				
				if (temp.name == _portal.destination)
				{
					player.x = temp.x + 16;
					player.y = temp.y + 64;
					
					portalTimer.addEventListener(TimerEvent.TIMER, didPortal);
					portalTimer.reset();
					portalTimer.start();
					
					break;
				}
			}
		}
	}
	
	private function didPortal(e)
	{
		portalTimer.stop();
		portalTimer.removeEventListener(TimerEvent.TIMER, didPortal);
		
		portaling = false;
	}
	
	private function shotEnemy(_shot:FlxObject, _enemy:FlxObject)
	{
		_shot.kill();
		_enemy.kill();
	}	
	
	override public function destroy()
	{
		portalTimer.removeEventListener(TimerEvent.TIMER, didPortal);
		
		map = null;
		level = null;
		UI = null;
		player = null;
		solid = null;
		portals = null;
		cards = null;
		platforms = null;
		exits = null;
		enemies = null;
		portaling = false;
		portalTimer = null;
	}
	
	override public function update(e)
	{
		if (UI.escapeMenu.visible) e = 0.0;
		else
		{
			FlxG.collide(player, platforms);
			
			FlxG.overlap(player, solid, FlxObject.separate);
			FlxG.overlap(cards, player, getCard);
			FlxG.overlap(exits, player, doExit);
			FlxG.overlap(portals, player, doPortal);
			FlxG.overlap(shots, enemies, shotEnemy);
			
			if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
			
			if (!player.isOnScreen() && !portaling) FlxG.resetState();
			
			if (!player.alive) FlxG.resetState();
		}
		
		super.update(e);
	}
}