package swagEngine.yoloController.playerSwag ;

import flixel.FlxG;
import nape.geom.Vec2;

/**
 * ...
 * @author Sjoer van der Ploeg
 */
 
class PlayerController
{
		// MAKE THE PLAYER MOVE
		// PORT STUFF OVER FROM LEVELHANDLER
		// ADD CARD SLOTS AND OPTIONAL ABILITIES
	private var player:PlayerRenderer;
	
	public function new(Player:PlayerRenderer)
	{
		player = Player;
	}
	
	public function update()
	{
//		if (FlxG.keys.justPressed.UP && ((player.body.velocity.y >= 0 && player.body.velocity.y <= 64) || (player.body.velocity.y <= 0 && player.body.velocity.y >= -64)))
		if (FlxG.keys.justPressed.UP)
		{
			player.body.applyImpulse(new Vec2(0, -750));
		}
		
		if (FlxG.keys.justPressed.DOWN)
		{
			player.body.applyImpulse(new Vec2(0, 750));
		}
		
		if (FlxG.keys.pressed.LEFT)
		{
			player.flipX = true;
			player.body.applyImpulse(new Vec2(-100, 0));
		}
		
		if (FlxG.keys.pressed.RIGHT)
		{
			player.flipX = false;
			player.body.applyImpulse(new Vec2(100, 0));
		}
	}
}