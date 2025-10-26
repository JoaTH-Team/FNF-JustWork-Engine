package;

import flixel.FlxGame;
import flixel.system.FlxMetadataFormat;
import flixel.system.FlxModding;
import haxe.ui.Toolkit;
import openfl.display.BitmapData;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
	
		FlxModding.init();
		Toolkit.init();
    	haxe.ui.focus.FocusManager.instance.autoFocus = false;
    	haxe.ui.tooltips.ToolTipManager.defaultDelay = 200;

		addChild(new FlxGame(0, 0, states.PlayState));

		if (!FlxModding.exists("template")) {
			FlxModding.create("newMod", new BitmapData(128, 128), new FlxMetadataFormat().fromDynamicData({
				name: "New Awesome Mod",
				version: "1.2.3",
				description: "This is a brand new mod for the world!",

				credits: [
					{
						name: "your_name",
						title: "What role you took in making the mod",
						socials: "https://your-website.com"
					}
				],

				priority: 1,
				active: true,
			}));
		}
	}
}
