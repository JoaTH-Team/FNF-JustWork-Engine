package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class InitState extends MusicBeatState {
    var bar:FlxBar;
    var titleText:FlxText;
    var curPercent:Float = 0;

    override function create() {
        super.create();

		bar = new FlxBar(0, FlxG.height * 0.9, LEFT_TO_RIGHT, 601, 19, this, "curPercent", 0, 2, true);
		bar.createFilledBar(0xff3c3c3c, 0xffffffff, true, FlxColor.BLACK, 4);
		bar.screenCenter(X);
		bar.solid = true;
		add(bar);
    
        titleText = new FlxText(0, FlxG.height * 0.4, FlxG.width, "Initializing...");
        titleText.setFormat(null, 32, 0xffffff, "center");
        add(titleText);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        bar.percent = curPercent;

        // since we don't have any real loading, just fake it
        curPercent += elapsed * 15;

        if (curPercent >= 100) {
            FlxG.switchState(getClasses());
        }
    }

    function getClasses():FlxState {
        return new states.PlayState();
    }
}