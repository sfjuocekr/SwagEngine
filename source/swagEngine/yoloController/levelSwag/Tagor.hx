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

class Tagor extends FlxState
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
		
		level = new LevelParser("assets/levels/Tagor/");				// LOAD THE LEVEL, HERE IS WERE YOU ADD STUFF TO THE STUFF DECLARED ABOVE LIKE COINS
		
		add(level.staticTiles);											// TILES THAT BELONG TO THE LEVEL GO FIRST
		add(platforms);
		add(coins);														// SOME STUFF TO PICKUP
		
		level.loadObjects(this);
		add(level.nointeractionTiles);										// FOREGROUND GOES LAST
	}
	
	private function getCoin(coin:FlxObject, player:FlxObject)
	{		
		coin.kill();													// DELETE THE COIN IF IT WAS PICKED UP
		if (coins.countLiving() == 0) exit.exists = true;				// IF ALL COINS ARE TAKEN, MAKE THE EXIT APPEAR
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.overlap(boundaries, player)) FlxG.resetState();							// COLLISION BETWEEN BOUNDARIES AND PLAYER = PLAYER DEAD
		if (FlxG.overlap(exit, player)) FlxG.resetState();							// COLLISION BETWEEN EXIT AND PLAYER = LEVEL DONE
		
		FlxG.overlap(coins, player, getCoin);										// COLLISION BETWEEN COINS AND PLAYER = PICK UP COIN
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		
		super.update(FlxG.elapsed);
	}
}