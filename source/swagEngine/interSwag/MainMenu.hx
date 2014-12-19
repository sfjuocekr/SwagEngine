package swagEngine.interSwag ;

import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import openfl.system.System;
import swagEngine.swagHandler.Settings;
import swagEngine.yoloController.levelSwag.*;
import nape.space.Space;
import flixel.addons.nape.FlxNapeSpace;
import nape.geom.Vec2;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class MainMenu extends FlxState
{
	private var levelButton:Array<FlxButtonPlus> = new Array();
	
	override public function create():Void
	{
		super.create();
		
		if (FlxNapeSpace.space == null) FlxNapeSpace.init();
		
		FlxG.mouse.useSystemCursor = false;
		
		for (i in Settings.levels)
		{
			levelButton[i] = new FlxButtonPlus((Settings.gameWidth * 0.5) - 64, 32 + (i * 32 + 4), startLevel.bind(i), null, 128, 32);
			levelButton[i].loadButtonGraphic(new FlxSprite(0, 0, FlxAssets.getBitmapData("assets/buttons/" + i + ".png")), new FlxSprite(0, 0, FlxAssets.getBitmapData("assets/buttons/" + i + "_hl.png")));
			add(levelButton[i]);
		}
		
		FlxG.fixedTimestep = false;
	}
		
	private function startLevel(level:Int)
	{
		switch (level)
		{
			case 0: System.exit(0);
			case 1:	FlxG.switchState(new Tutorial());
		}
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float)
	{
		super.update(FlxG.elapsed);
		
		if (FlxG.keys.justPressed.ESCAPE) System.exit(0);
	}	
}