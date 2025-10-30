package;

import flixel.FlxGame;
import flixel.FlxState;
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

		addChild(new FlxGame(0, 0, getClasses()));
		addChild(new FPS(10, 3, FlxColor.WHITE));

		PolymodHandler.reload();
	}

	function getClasses():Class<FlxState> {
		#if SKIP_TO_STAGE_EDITOR
		return states.editors.StageEditorState;
		#else
		return states.PlayState;
		#end
	}
}
