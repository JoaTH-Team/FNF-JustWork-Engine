package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import game.scripts.PolymodHandler;

class InitState extends MusicBeatState {
    var bar:FlxBar;
    var titleText:FlxText;
    var curPercent:Float = 0;
    var loadingTasks:Array<Void->Void>;
    var currentTask:Int = 0;
    var totalTasks:Int = 0;

    override function create() {
        super.create();

        bar = new FlxBar(0, FlxG.height * 0.9, LEFT_TO_RIGHT, 601, 19, this, "curPercent", 0, 100, true);
        bar.createFilledBar(0xff3c3c3c, 0xffffffff, true, FlxColor.BLACK, 4);
        bar.screenCenter(X);
        bar.solid = true;
        add(bar);
    
        titleText = new FlxText(0, FlxG.height * 0.4, FlxG.width, "Initializing...");
        titleText.setFormat(null, 32, 0xffffff, "center");
        add(titleText);

        setupLoadingTasks();
    }

    function setupLoadingTasks() {
        loadingTasks = [
            initPolymod,
            finishedLoading
        ];
        
        totalTasks = loadingTasks.length;
        currentTask = 0;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        // Process loading tasks
        if (currentTask < totalTasks) {
            var task = loadingTasks[currentTask];
            task();
            currentTask++;
            
            // Update progress based on completed tasks
            curPercent = (currentTask / totalTasks) * 100;
            updateLoadingText();
        }

        bar.percent = curPercent;

        if (curPercent >= 100) {
            FlxG.switchState(getClasses());
        }
    }

    function updateLoadingText() {
        switch(currentTask) {
            case 0:
                titleText.text = "Init Polymod...";
            case 1:
                titleText.text = "Finished Loading...";
        }
    }

    function initPolymod() {
        trace("Init Polymod...");
        PolymodHandler.reload();
        
        #if cpp
        cpp.vm.Thread.create(function() {
            Sys.sleep(0.1);
        });
        #end
    }

    function finishedLoading() {
        trace("Finished init...");
        
        #if cpp
        cpp.vm.Thread.create(function() {
            Sys.sleep(0.1);
        });
        #end
    }

    function getClasses():FlxState {
        return new states.PlayState();
    }
}