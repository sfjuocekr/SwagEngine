package swagEngine.yoloController.levelSwag ;

import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeTilemap;
import flixel.animation.FlxAnimation;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKeyList;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import nape.dynamics.InteractionFilter;
import nape.geom.Vec2;
import nape.phys.Material;
import swagEngine.interSwag.Interface;
import swagEngine.interSwag.MainMenu;
import swagEngine.yoloController.levelSwag.customSwag.ParseFlxTiledMap;
import swagEngine.yoloController.levelSwag.yoloObjects.*;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import flixel.tile.FlxTilemap;
import nape.dynamics.InteractionFilter;
import flixel.addons.nape.FlxNapeSprite;
import openfl.tiled.FlxTile;
import flixel.addons.effects.FlxWaveSprite;
import openfl.tiled.FlxLayer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Tagor extends FlxState
{
	private var map:String = "Tagor";
	private var level:ParseFlxTiledMap;
	private var UI:Interface;
	private var player:PlayerRenderer = null;
	private var bounds:FlxGroup = new FlxGroup();
	private var cards:FlxGroup = new FlxGroup();
	private var platforms:FlxGroup = new FlxGroup();
	private var exits:FlxGroup = new FlxGroup();
	private var solid:FlxGroup = new FlxGroup();
	private var enemies:FlxGroup = new FlxGroup();
	
	override public function create()
	{
		super.create();
		
		FlxNapeSpace.init();
		FlxNapeSpace.space.gravity.y = 2000;
		FlxNapeSpace.space.worldLinearDrag = 2;
		FlxNapeSpace.drawDebug = true;
		
		var wantedObjects:Array<String> = ["Cards", "Exit", "Player", "Platforms", "Enemies"];				// 0 = Cards, 1 = Exit, 2 = Player, 3 = Platforms, 4 = Enemies
		
		level = new ParseFlxTiledMap(map, wantedObjects);
		
		// COLLISION LAYERS ARE DONE BY PHYSICS
		solid.add(level.napeMap("Level", true));
		
		player = new PlayerRenderer(FlxG.width * 0.5, FlxG.height * 0.5, level._map.getTilesetByGID(level.objects[0].objects[0].gid).image.texture);
		
		//FIX IMAGE LAYER DOWN HERE
		add(level.bgColor);
		
		// ADD STUFF TO SHOW FROM HERE ON TO THE STATE WITH ADD:
		
		for (card in level.objects[2])
			cards.add(new Card(card.x, card.y, "assets/levels/" + map + "/" + level._map.getTilesetByGID(card.gid).image.source));
		add(cards);
		
		add(level.getLayerByName("Background"));
		
				for (level_exit in level.objects[1])
		{
			var exit = new FlxSprite(level_exit.x - level_exit.width * 0.5, level_exit.y + level_exit.height * 0.5);
				exit.makeGraphic(level_exit.width, level_exit.height, 0xff3f3f3f);
				exit.exists = false;
			exits.add(exit);
		}
		add(exits);
		
		add(solid);		// Level
		add(player);
		
		for (platform in level.objects[3])
		{
			if (platform.type == "vertical") platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), true));
			else if (platform.type == "horizontal") platforms.add(new Platform(platform.x, platform.y, level._map.getTilesetByGID(platform.gid).image.texture, platform.properties.get("min"), platform.properties.get("max"), false));
		}
		add(platforms);
		
		//enemies.add(new Enemy(128, 128, "bird"));
		//enemies.add(new Enemy(256, 256, "rabbit"));
		add(enemies);
		
		add(level.getLayerByName("Foreground"));
		
		UI = new Interface();
		add(UI);
		
		FlxG.camera.setScrollBounds(0, level.totalWidth, 0, level.totalHeight);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, level.totalWidth, level.totalHeight);
		
		player.health = 1000;
		player.setPosition(level.objects[0].objects[0].x, level.objects[0].objects[0].y);
	}
	
	private function getCard(card:FlxObject, player:FlxObject)
	{	
		card.destroy();
		if (cards.countLiving() == 0) exits.members[0].exists = true;
	}
	
	private function doExit(exit:FlxObject, player:FlxObject)
	{	
		if (exit.exists) FlxG.resetState();
	}
	
	private function moving(a:FlxNapeSprite, b:FlxNapeSprite)
	{
		if (!FlxG.keys.anyPressed(["LEFT", "RIGHT"])) b.body.velocity.x = a.body.velocity.x * 1.15;
		if (!FlxG.keys.anyPressed(["UP", "DOWN"])) b.body.velocity.y = a.body.velocity.y;
		
		// FIX THE "STICKY" SIDE
	}
	
	override public function update(elapsed:Float)
	{
		FlxG.overlap(platforms, player, moving);
		FlxG.overlap(cards, player, getCard);
		FlxG.overlap(exits, player, doExit);
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		if (!player.isOnScreen()) FlxG.resetState();
		
		if (!player.alive) FlxG.resetState();
		UI.health = player.health;
		
		super.update(FlxG.elapsed);
	}
}