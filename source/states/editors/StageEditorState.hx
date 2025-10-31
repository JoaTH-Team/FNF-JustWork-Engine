package states.editors;

import flixel.FlxG;
import haxe.ui.components.Button;
import haxe.ui.components.SectionHeader;
import haxe.ui.components.TextField;
import haxe.ui.containers.VBox;
import haxe.ui.containers.windows.Window;
import haxe.ui.containers.windows.WindowManager;
import haxe.ui.core.Screen;
import haxe.ui.core.TextInput;
import haxe.ui.events.MouseEvent;

class StageEditorState extends MusicBeatState
{
    override function create() {
        super.create();

        createUI();
    }

    var window:Window;

    function createUI() {
        window = new Window();
        window.title = "Stage Editor Panel";
        window.closable = false; // prevent from close and lose that window
        window.maximizable = false;
        window.minimizable = false;
        WindowManager.instance.addWindow(window);

        var sectionHeader:SectionHeader = new SectionHeader();
        sectionHeader.text = "Config";
        window.addComponent(sectionHeader);

        var textField:TextField = new TextField();
        textField.text = "stage";
        window.addComponent(textField);

        var miscHeader:SectionHeader = new SectionHeader();
        miscHeader.text = "Misc";
        window.addComponent(miscHeader);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.justPressed.BACK) {
            // WindowManager.instance.closeWindow(window);
            FlxG.switchState(() -> new PlayState());
        }
    }
}