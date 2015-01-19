package swagEngine.yoloController.levelSwag.yoloObjects.animationSwag;

import flixel.FlxSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Spider extends FlxSprite
{
	public function new(_x:Float = 0, _y:Float = 0) 
	{
		super(_x, _y);
		
		loadGraphic("assets/animations/spider.png", true, 64, 64);
		y -= height;
		
		var framesArray = new Array();
			for (i in 0...12) framesArray[i] = i;
			
		animation.add("dangle", framesArray, 5, true);
		animation.play("dangle");
	}
	
	override public function update(e:Float)
	{
		trace(animation.curAnim.curIndex);
		super.update(e);
	}
}