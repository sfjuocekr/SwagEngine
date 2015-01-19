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
	private var originalY:Float = 0;
	
	public function new(_x:Float = 0, _y:Float = 0, _rotation:Float, _player:PlayerRenderer)
	{
		super(_x, _y);
		
		player = _player;
		
		loadGraphic("assets/animations/rabbit.png", true, 64, 128);
		
		switch (angle)
		{
			case 0:
				y -= height;
			case 180:
				x -= width * 2;
				y += height;
		}
		
		originalY = y;
		
		var framesArray = new Array();
			for (i in 5...135) framesArray[i - 5] = i;
			
		animation.add("pop", framesArray, 45, false);
		
		framesArray = [0, 1, 2, 3, 4, 135, 136, 137];
		animation.add("inside", framesArray, 2, false);
		
		animation.play("pop");
		
		immovable = true;
		
		angle = _rotation;
	}
	
	override public function destroy()
	{
		player = null;
	}
	
	override public function update(e)
	{
		if (e == 0.0) return;
		
		switch (animation.name)
		{
			case "pop":
				if (animation.finished) animation.play("inside");
				
				height = 128;
				offset.y = 0;
				y = originalY;
					
				if (overlaps(player))
				{
					height = 64;
					offset.y = 64;
					y = originalY + 64;
					
					FlxG.overlap(player, this, FlxObject.separate);
					trace("poop");
				}
			
			case "inside":
				if (animation.finished && !overlaps(player)) animation.play("pop");
				
				height = 64;
				offset.y = 64;
				y = originalY + 64;
					
				FlxG.overlap(player, this, FlxObject.separate);
		}
		
		if (overlaps(player) && animation.name == "pop") player.hurt(20);
		//else if (overlaps(player) && animation.name == "inside") FlxG.overlap(player, this, FlxObject.separate);
		
		//FlxG.overlap(player, this, FlxObject.separate);
		
		super.update(e);
	}
}