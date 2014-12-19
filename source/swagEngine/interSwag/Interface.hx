package swagEngine.interSwag;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Interface	extends FlxSpriteGroup
{
	public var cardOverlay:FlxSprite = new FlxSprite();		//0
	public var actionBar:FlxSprite = new FlxSprite();		//1
	public var minimap:FlxSprite = new FlxSprite();			//2
	public var escapeMenu:FlxSprite = new FlxSprite();		//3
	
	public function new() 
	{
		super();
		
		this.scrollFactor.set(0, 0);
		
			cardOverlay.makeGraphic(384, 128, FlxColor.BLACK);
			cardOverlay.x = FlxG.width - cardOverlay.width;
			cardOverlay.y = FlxG.height - cardOverlay.height;
		add(cardOverlay);
		
			actionBar.makeGraphic(256, 32, FlxColor.BLACK);
			actionBar.x = 0;
			actionBar.y = FlxG.height - actionBar.height;
		add(actionBar);
		
			minimap.makeGraphic(128, 128, FlxColor.BLACK);
			minimap.x = FlxG.width - minimap.width;
			minimap.y = 0;
		add(minimap);
		
			escapeMenu.makeGraphic(256, 384, FlxColor.BLACK);
			escapeMenu.x = (FlxG.width * 0.5) - (escapeMenu.width * 0.5);
			escapeMenu.y = (FlxG.height * 0.5) - (escapeMenu.height * 0.5);
			escapeMenu.visible = false;
		add(escapeMenu);
	}
	
	override public function update(elapsed:Float)
	{
		super.update(FlxG.elapsed);
		
		//ADD SOMETHING TO HANDLE THE PAUSE MENU
		if (FlxG.keys.justPressed.P) escapeMenu.visible = !escapeMenu.visible;
		if (escapeMenu.visible && FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		
		//ADD SOMETHING TO HANDLE UI UPDATES OR DO IT SOMEWHERE ELSE
	}
}