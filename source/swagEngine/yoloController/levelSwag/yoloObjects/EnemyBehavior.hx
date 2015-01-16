package swagEngine.yoloController.levelSwag.yoloObjects;

import flixel.FlxSprite;
import swagEngine.yoloController.playerSwag.PlayerRenderer;
import flixel.FlxObject;
import flixel.math.FlxPoint;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class EnemyBehavior
{
	private var parent:FlxSprite;
	private var player:PlayerRenderer;
	private var xMovement:Float = 1;
	private var min:Int = 0;
	private var max:Int = 0;
	private var retreat:FlxPoint;
	
	public var type:String;
	
	public function new(_type:String, _parent:FlxSprite, _player:PlayerRenderer, _min:Int, _max:Int) 
	{
		parent = _parent;
		player = _player;
		type = _type;
		min = _min;
		max = _max;
		
		retreat = new FlxPoint(parent.x, parent.y);
	}
	
	public function update()
	{
		switch (type)
		{
			case "passive":
				passive();
			
			case "aggressive":
				aggressive();
		}
	}
	
	private function passive()
	{
		// passive behavior
		
		if (parent.x < min * 32) xMovement = 1;
		else if (parent.x > max * 32) xMovement = -1;
		
		parent.velocity.x = xMovement * 64;
		
		if 			(player.y < parent.y) parent.acceleration.y = -parent.drag.y * 0.75;
		else if 	(player.y > parent.y) parent.acceleration.y =  parent.drag.y * 0.75;
	}
	
	private function aggressive()
	{
		// aggressive behavior
		
		
		// Tagor's code
		
		parent.acceleration.x = parent.acceleration.y = 0;
		
		// distance on x axis to player
		var xdistance:Float = player.x - parent.x;
		
		// distance on y axis to player
		var ydistance:Float = player.y - parent.y;
		
		// absolute distance to player (squared, because there's no need to spend cycles calculating the square root)
		var distancesquared:Float = xdistance * xdistance + ydistance * ydistance;
		
		// distance at which it will start chasing the player
		if (distancesquared < 100000)
		{
			if 			(player.x < parent.x) parent.acceleration.x = -parent.drag.x;
			else if 	(player.x > parent.x) parent.acceleration.x =  parent.drag.x;
			
			if 			(player.y < parent.y) parent.acceleration.y = -parent.drag.y;
			else if 	(player.y > parent.y) parent.acceleration.y =  parent.drag.y;
		}
		else passive();
	}
}