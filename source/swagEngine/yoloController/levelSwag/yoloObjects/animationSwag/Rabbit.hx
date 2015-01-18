package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import swagEngine.yoloController.playerSwag.PlayerRenderer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Rabbit extends FlxSprite
{
	private var player:PlayerRenderer;
	
	public function new(_x:Float = 0, _y:Float = 0, _player:PlayerRenderer)
	{
		super(_x, _y);
		
		player = _player;
		
		loadGraphic("assets/animations/rabbit.png", true, 64, 128);
		
		y -= height;
		
		var framesArray = new Array();
			for (i in 5...135) framesArray[i - 5] = i;
			
		animation.add("pop", framesArray, 45, false);
		
		framesArray = [0, 1, 2, 3, 4, 135, 136, 137];
		animation.add("inside", framesArray, 2, false);
		
		animation.play("pop");
		
		immovable = true;
	}
	
	override public function destroy()
	{
		player = null;
	}
	
	override public function update(e)
	{
		if (e == 0.0) return;
		
		if (animation.finished)
			switch (animation.name)
			{
				case "pop":
					animation.play("inside");
					
					height = 64;
					offset.y = 64;
					y += 64;
				
				case "inside":
					if (!overlaps(player))
					{
						animation.play("pop");
						
						height = 128;
						offset.y = 0;
						y -= 64;
					}
			}
		
		if (overlaps(player) && animation.name == "pop") player.hurt(20);
		else if (overlaps(player) && animation.name == "inside") FlxG.overlap(player, this, FlxObject.separate);
		
		super.update(e);
	}
}