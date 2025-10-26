package;

import flixel.FlxGame;
import game.scripts.PolymodHandler;
import haxe.ui.Toolkit;
import openfl.display.BitmapData;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
	
		Toolkit.init();
    	haxe.ui.focus.FocusManager.instance.autoFocus = false;
    	haxe.ui.tooltips.ToolTipManager.defaultDelay = 200;

		addChild(new FlxGame(0, 0, states.PlayState));

		PolymodHandler.reload();
	}
}
