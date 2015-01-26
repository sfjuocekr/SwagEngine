package swagEngine.interSwag.cardSwag;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

/**
 * ...
 * @author Sjoer van der Ploeg						// SHOULD ADD KEYS HERE
 */

class Card extends FlxSpriteGroup
{
	public var type:String = "none";
	
	private var front:FlxSprite = new FlxSprite(0, 0, "assets/images/card.png");
	private var back:FlxSprite = new FlxSprite(0, 0, "assets/images/cardslot.png");
	
	private var image:FlxSprite = new FlxSprite(4, 10);
	
	public var ready:Bool = false;
	
	public function new(_x:Float, _y:Float, _type:String)
	{
		super(_x, _y);
		
		setType(type);
		
		add(front);
		add(image);
		add(back);
	}
	
	public function setType(_type:String)
	{
		if (type == _type) return;
		
		type = _type;
		
		switch (type)
		{
			case "shrink":
				image.loadGraphic("assets/images/shrink.png");
				
			case "float":
				image.loadGraphic("assets/images/float.png");
				
			case "see":
				image.loadGraphic("assets/images/see.png");
				
			case "shoot":
				image.loadGraphic("assets/images/shoot.png");
				
			case "touch":
				image.loadGraphic("assets/images/touch.png");
				
			case "jump":
				image.loadGraphic("assets/images/jump.png");
		}
	}
	
	override public function update(e:Float)
	{
		if (e == 0) return;
		
		front.visible = image.visible = ready;
		back.visible = !ready;
		
		super.update(e);
	}
}