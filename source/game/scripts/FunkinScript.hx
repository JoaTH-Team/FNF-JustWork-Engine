package game.scripts;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import game.paths.Spritesheet;
import rulescript.RuleScript;
import rulescript.RuleScriptInterp;
import rulescript.parsers.HxParser;
import states.PlayState;
import sys.io.File;

class FunkinScript
{
    public var parser:HxParser = new HxParser();
    public var interp:RuleScriptInterp = new RuleScriptInterp();
    public var script:RuleScript;

    public function new(file:String) {
        script = new RuleScript(interp, parser);
		script.scriptName = ~/\.(hx|hxs|hxc|hscript)$/.replace(file.split('/').pop(), '');

		parser.allowAll();

        // Flixel Classes
        setVariable("FlxG", FlxG);
        setVariable("FlxSprite", FlxSprite);
		setVariable("FlxColor", FlxScriptColor.main());
		setVariable("FlxText", FlxText);
		setVariable("FlxCamera", FlxCamera);

		// JustWork Engine Classes
		setVariable("Paths", Paths);
		setVariable("Spritesheet", Spritesheet);

        setVariable("PlayState", PlayState);
		if (FlxG.state is PlayState && PlayState.instance != null)
			setVariable("game", PlayState.instance);

        script.tryExecute(File.getContent(Paths.data('$file.hxs')));
    }

	public function setVariable(name:String, val:Dynamic):Void
	{
		try
		{
			script?.variables.set(name, val);
		}
		catch (e:Dynamic)
			FlxG.stage.application.window.alert(Std.string(e), 'HScript Error!');
	}

	public function getVariable(name:String):Dynamic
	{
		try
		{
			if (script.variables.exists(name))
				return script?.variables.get(name);
		}
		catch (e:Dynamic)
			FlxG.stage.application.window.alert(Std.string(e), 'HScript Error!');
		return null;
	}

	public function removeVariable(name:String):Void
	{
		try
		{
			script?.variables.remove(name);
		}
		catch (e:Dynamic)
			FlxG.stage.application.window.alert(Std.string(e), 'HScript Error!');
	}

	public function existsVariable(name:String):Bool
	{
		try
		{
			return script?.variables.exists(name);
		}
		catch (e:Dynamic)
			FlxG.stage.application.window.alert(Std.string(e), 'HScript Error!');
		return false;
	}

	public function executeFunc(funcName:String, ?args:Array<Dynamic>):Dynamic
	{
		if (existsVariable(funcName))
		{
			try
			{
				return Reflect.callMethod(this, getVariable(funcName), args == null ? [] : args);
			}
			catch (e:Dynamic)
				FlxG.stage.application.window.alert(Std.string(e), 'HScript Error!');
		}
		return null;
	}
}