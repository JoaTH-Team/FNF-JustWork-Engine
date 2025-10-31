package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.util.FlxColor;
import game.scripts.PolymodHandler;
import haxe.ui.Toolkit;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
	
		Toolkit.init();
    	haxe.ui.focus.FocusManager.instance.autoFocus = false;
    	haxe.ui.tooltips.ToolTipManager.defaultDelay = 200;

		addChild(new FlxGame(0, 0, states.InitState));
		addChild(new FPS(10, 3, FlxColor.WHITE));

		FlxG.mouse.useSystemCursor = true;
		PolymodHandler.reload();
	}
}
