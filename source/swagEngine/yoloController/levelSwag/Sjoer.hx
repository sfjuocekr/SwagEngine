package swagEngine.yoloController.levelSwag ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import swagEngine.interSwag.MainMenu;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import flixel.addons.nape.FlxNapeSpace;
import openfl.tiled.TiledMap;
import openfl.tiled.FlxTiledMap;
import flixel.addons.nape.FlxNapeTilemap;
/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Sjoer extends FlxState
{
	//public var level:LevelParser;
	public var level:FlxTiledMap;
	public var platforms:FlxSpriteGroup = new FlxSpriteGroup();
	public var coins:FlxGroup = new FlxGroup();
	public var exit:FlxSprite;
	public var player:PlayerRenderer;
	public var boundaries:FlxGroup = new FlxGroup();
	
	override public function create():Void
	{
		super.create();
		
		//FlxNapeSpace.init();
		//FlxNapeSpace.space.gravity.y = 1000;
		//FlxNapeSpace.space.worldLinearDrag = 1;
		
		FlxNapeSpace.drawDebug = true;
		
		//level = new LevelParser("assets/levels/Sjoer/");
		level = FlxTiledMap.fromAssets("assets/levels/Sjoer/level.tmx");
		
		add(level);
		
		//add(level);
		
		//var background:FlxSprite = new FlxSprite(0, 0);
		//background.makeGraphic(Std.int(FlxG.stage.stageWidth), Std.int(FlxG.stage.stageHeight), 0xff55b4ff);
		//background.scrollFactor.set(0, 0);
		//add(background);

		//add(level.waterTiles);
		//add(level.cloudTiles);
		//add(level.staticTiles);
		//add(platforms);
		//add(coins);
		//add(level.nointeractionTiles);
		
		//level.loadObjects(this);
	}
	
	private function getCoin(coin:FlxObject, player:FlxObject)
	{		
		coin.kill();
		if (coins.countLiving() == 0) exit.exists = true;
	}

	override public function update(elapsed:Float)
	{
		//if (FlxG.overlap(boundaries, player)) FlxG.resetState();
		//if (FlxG.overlap(exit, player)) FlxG.resetState();
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		
		super.update(FlxG.elapsed);
	}
}