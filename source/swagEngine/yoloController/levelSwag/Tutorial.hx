package swagEngine.yoloController.levelSwag ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import swagEngine.interSwag.MainMenu;
import swagEngine.yoloController.levelSwag.customSwag.LevelParser;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import flixel.addons.nape.FlxNapeSpace;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Tutorial extends FlxState
{
	public var level:LevelParser;
	public var platforms:FlxSpriteGroup = new FlxSpriteGroup();
	public var coins:FlxGroup = new FlxGroup();
	public var exit:FlxSprite;
	public var player:PlayerRenderer;
	public var boundaries:FlxGroup = new FlxGroup();
	
	override public function create():Void
	{
		super.create();
		
		FlxNapeSpace.init();
		FlxNapeSpace.space.gravity.y = 1000;
		FlxNapeSpace.space.worldLinearDrag = 1;
		
		level = new LevelParser("assets/levels/tutorial/");
		
		add(level.staticTiles);
		add(platforms);
		add(coins);
		
		level.loadObjects(this);
		add(level.nointeractionTiles);
	}
	
	private function getCoin(coin:FlxObject, player:FlxObject)
	{
		coin.kill();
		if (coins.countLiving() == 0) exit.exists = true;
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.overlap(boundaries, player)) FlxG.resetState();
		if (FlxG.overlap(exit, player)) FlxG.resetState();
		
		FlxG.overlap(coins, player, getCoin);
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		
		super.update(FlxG.elapsed);
	}
}