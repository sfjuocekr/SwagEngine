package swagEngine.yoloController.playerSwag ;

import flixel.FlxG;
import haxe.CallStack;
import haxe.Timer;
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
	private var scaled:Bool;
	private var timer:Timer = new Timer(5000);
	
	public function new(Player:PlayerRenderer)
	{
		player = Player;
	}
	
	public function update()
	{
//		if (FlxG.keys.justPressed.UP && ((player.body.velocity.y >= 0 && player.body.velocity.y <= 64) || (player.body.velocity.y <= 0 && player.body.velocity.y >= -64)))
		if (FlxG.keys.justPressed.UP)
		{
			player.body.applyImpulse(new Vec2(0, -5000));
		}
		
		if (FlxG.keys.justPressed.DOWN && !scaled)
		{
			//player.body.applyImpulse(new Vec2(0, 150));
			
			// FIX THIS SHIT, NEED TO REMOVE NAPE SPACE AND ADD IT BACK AFTERWARDS I GUESS
			// GOOD NIGHT
			
			player.scale.set(0.5, 0.5);
			player.body.scaleShapes(0.5, 0.5);
			
			timer.run = function yolo()
			{
				timer.stop();
				player.scale.set(1, 1);
				player.body.scaleShapes(2, 2);
				scaled = false;
			}
			
			scaled = true;
		}
		
		if (FlxG.keys.pressed.LEFT)
		{
			player.flipX = true;
			player.body.applyImpulse(new Vec2(-150, 0));
		}
		
		if (FlxG.keys.pressed.RIGHT)
		{
			player.flipX = false;
			player.body.applyImpulse(new Vec2(150, 0));
		}
	}
}