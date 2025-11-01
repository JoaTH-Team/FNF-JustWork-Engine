package states.editors;

import flixel.FlxG;
import flixel.FlxSprite;
import game.objects.Character;
import haxe.Json;
import haxe.ui.components.Button;
import haxe.ui.components.CheckBox;
import haxe.ui.components.DropDown;
import haxe.ui.components.NumberStepper;
import haxe.ui.components.SectionHeader;
import haxe.ui.components.TextField;
import haxe.ui.containers.HBox;
import haxe.ui.containers.VBox;
import haxe.ui.containers.windows.Window;
import haxe.ui.containers.windows.WindowManager;
import haxe.ui.data.ArrayDataSource;
import openfl.Assets;
import openfl.events.Event;
import openfl.net.FileFilter;
import openfl.net.FileReference;

using StringTools;

class CharacterEditorState extends MusicBeatState
{
    var window:Window;
    var character:Character;
    public static var characterToEdit:String = "boyfriend"; // same as the json data name

    var _file:FileReference;
    
    // UI Components
    var characterNameField:TextField;
    var assetsPathField:TextField;
    var iconField:TextField;
    var colorField:TextField;
    var animationDropdown:DropDown;
    var animNameField:TextField;
    var animPrefixField:TextField;
    var offsetXStepper:NumberStepper;
    var offsetYStepper:NumberStepper;
    var frameRateStepper:NumberStepper;
    var loopedCheckbox:CheckBox;
    var saveButton:Button;
    var loadButton:Button;
    var playAnimationButton:Button;
    
    var currentAnimationIndex:Int = 0;

    override function create() {
        super.create();

        var bg:FlxSprite = new FlxSprite(0, 0, Paths.image('menuDesat'));
        bg.screenCenter();
        bg.scrollFactor.set(0, 0);
        add(bg);

        character = new Character(characterToEdit, 0, 0, false);
        character.playAnim("idle", true);
        character.screenCenter();
        add(character);

        createUI();
        loadCharacterData();
    }

    function createUI() {
        window = new Window();
        window.title = "Character Editor - " + characterToEdit;
        window.closable = false;
        window.maximizable = false;
        window.minimizable = false;
        window.width = 400;
        window.height = 600;
        window.x = FlxG.width - window.width - 20;
        window.y = 20;
        WindowManager.instance.addWindow(window);

        var mainContainer = new VBox();
        mainContainer.percentWidth = 100;
        mainContainer.percentHeight = 100;

        // Character Properties Section
        var charSection = new SectionHeader();
        charSection.text = "Character Properties";
        mainContainer.addComponent(charSection);

        var charForm = new VBox();
        charForm.percentWidth = 100;
        
        // Name field with label
        var nameBox = new HBox();
        nameBox.percentWidth = 100;
        characterNameField = new TextField();
        characterNameField.text = "Boyfriend";
        characterNameField.percentWidth = 100;
        nameBox.addComponent(characterNameField);
        charForm.addComponent(nameBox);
        
        // Assets Path field with label
        var assetsBox = new HBox();
        assetsBox.percentWidth = 100;
        assetsPathField = new TextField();
        assetsPathField.text = "BOYFRIEND";
        assetsPathField.percentWidth = 100;
        assetsBox.addComponent(assetsPathField);
        charForm.addComponent(assetsBox);
        
        // Icon field with label
        var iconBox = new HBox();
        iconBox.percentWidth = 100;
        iconField = new TextField();
        iconField.text = "bf";
        iconField.percentWidth = 100;
        iconBox.addComponent(iconField);
        charForm.addComponent(iconBox);
        
        // Color field with label
        var colorBox = new HBox();
        colorBox.percentWidth = 100;
        colorField = new TextField();
        colorField.text = "0x00FF00";
        colorField.percentWidth = 100;
        colorBox.addComponent(colorField);
        charForm.addComponent(colorBox);
        
        mainContainer.addComponent(charForm);

        // Animation Properties Section
        var animSection = new SectionHeader();
        animSection.text = "Animation Properties";
        mainContainer.addComponent(animSection);

        var animControlBox = new HBox();
        animControlBox.percentWidth = 100;
        animationDropdown = new DropDown();
        animationDropdown.percentWidth = 50;
        animationDropdown.onChange = function(_) {
            if (animationDropdown.selectedIndex >= 0) {
                loadAnimationData(animationDropdown.selectedIndex);
            }
        }
        animControlBox.addComponent(animationDropdown);
        
        playAnimationButton = new Button();
        playAnimationButton.text = "Play Animation";
        // playAnimationButton.percentWidth = 20;
        playAnimationButton.onClick = function(_) {
            playCurrentAnimation();
        }
        animControlBox.addComponent(playAnimationButton);
        
        mainContainer.addComponent(animControlBox);

        var animForm = new VBox();
        animForm.percentWidth = 100;
        
        // Animation Name field with label
        var animNameBox = new HBox();
        animNameBox.percentWidth = 100;
        animNameField = new TextField();
        animNameField.percentWidth = 100;
        animNameBox.addComponent(animNameField);
        animForm.addComponent(animNameBox);
        
        // Animation Prefix field with label
        var animPrefixBox = new HBox();
        animPrefixBox.percentWidth = 100;
        animPrefixField = new TextField();
        animPrefixField.percentWidth = 100;
        animPrefixBox.addComponent(animPrefixField);
        animForm.addComponent(animPrefixBox);
        
        var offsetBox = new HBox();
        offsetBox.percentWidth = 100;
        
        var offsetXBox = new VBox();
        offsetXBox.percentWidth = 50;
        offsetXStepper = new NumberStepper();
        offsetXStepper.value = 0;
        offsetXStepper.step = 1;
        offsetXBox.addComponent(offsetXStepper);
        offsetBox.addComponent(offsetXBox);
        
        var offsetYBox = new VBox();
        offsetYBox.percentWidth = 50;
        offsetYStepper = new NumberStepper();
        offsetYStepper.value = 0;
        offsetYStepper.step = 1;
        offsetYBox.addComponent(offsetYStepper);
        offsetBox.addComponent(offsetYBox);
        
        animForm.addComponent(offsetBox);
        
        // Frame Rate field with label
        var frameRateBox = new HBox();
        frameRateBox.percentWidth = 100;
        frameRateStepper = new NumberStepper();
        frameRateStepper.value = 24;
        frameRateStepper.min = 1;
        frameRateStepper.max = 60;
        frameRateStepper.step = 1;
        frameRateStepper.percentWidth = 100;
        frameRateBox.addComponent(frameRateStepper);
        animForm.addComponent(frameRateBox);
        
        // Looped checkbox
        loopedCheckbox = new CheckBox();
        loopedCheckbox.text = "Looped Animation";
        animForm.addComponent(loopedCheckbox);
        
        mainContainer.addComponent(animForm);

        // Control Buttons
        var buttonBox = new HBox();
        buttonBox.percentWidth = 100;
        
        saveButton = new Button();
        saveButton.text = "Save Character";
        saveButton.percentWidth = 100;
        saveButton.onClick = function(_) {
            saveCharacterData();
        }

        loadButton = new Button();
        loadButton.text = "Load Character";
        loadButton.percentWidth = 100;
        loadButton.onClick = function(_) {
            loadCharacterJson();
        }
        
        buttonBox.addComponent(saveButton);
        buttonBox.addComponent(loadButton);
        mainContainer.addComponent(buttonBox);

        window.addComponent(mainContainer);
    }

    function loadCharacterData() {
        if (character.characterData == null) {
            trace("ERROR: character data is null!");
            return;
        }
        
        trace("Loading character data: " + character.characterData.name);
        trace("Animations count: " + character.characterData.animations.length);
        
        characterNameField.text = character.characterData.name;
        assetsPathField.text = character.characterData.assetsPath;
        iconField.text = character.characterData.icon;
        colorField.text = character.characterData.color;
        
        // Load animations into dropdown
        var animNames:Array<String> = [];
        for (anim in character.characterData.animations) {
            animNames.push(anim.name);
            trace("Found animation: " + anim.name);
        }
        
        if (animNames.length == 0) {
            trace("WARNING: No animations found in character data!");
            // Add a default placeholder
            animNames.push("No animations");
        }
        
        animationDropdown.dataSource = ArrayDataSource.fromArray(animNames);

        if (animNames.length > 0) {
            animationDropdown.selectedIndex = 0;
            loadAnimationData(0);
        }
    }

    function loadAnimationData(index:Int) {
        if (character.characterData == null || index < 0 || index >= character.characterData.animations.length) {
            trace("ERROR: Cannot load animation data at index " + index);
            // Clear fields if no valid animation
            animNameField.text = "";
            animPrefixField.text = "";
            offsetXStepper.value = 0;
            offsetYStepper.value = 0;
            frameRateStepper.value = 24;
            loopedCheckbox.selected = false;
            return;
        }
        
        currentAnimationIndex = index;
        var animData = character.characterData.animations[index];
        
        animNameField.text = animData.name;
        animPrefixField.text = animData.animPrefix;
        offsetXStepper.value = animData.animOffset[0];
        offsetYStepper.value = animData.animOffset[1];
        frameRateStepper.value = animData.frameRate;
        loopedCheckbox.selected = animData.looped;
        
        trace("Loaded animation: " + animData.name);
    }

    function playCurrentAnimation() {
        if (animationDropdown.selectedIndex >= 0) {
            var animName = character.characterData.animations[animationDropdown.selectedIndex].name;
            character.playAnim(animName, true);
        }
    }

    function loadCharacterJson() {
        _file = new FileReference();
        _file.addEventListener(Event.SELECT, onLoadCharacterJsonSelect);
        _file.addEventListener(Event.CANCEL, onLoadCharacterJsonCancel);
        _file.browse([new FileFilter("JSON Files", "*.json")]);
    }

    function onLoadCharacterJsonSelect(event:Event) {
        _file.removeEventListener(Event.SELECT, onLoadCharacterJsonSelect);
        _file.removeEventListener(Event.CANCEL, onLoadCharacterJsonCancel);
        _file.addEventListener(Event.COMPLETE, onLoadCharacterJsonComplete);
        _file.load();
    }

    function onLoadCharacterJsonCancel(event:Event) {
        _file.removeEventListener(Event.SELECT, onLoadCharacterJsonSelect);
        _file.removeEventListener(Event.CANCEL, onLoadCharacterJsonCancel);
        trace("Load character cancelled");
    }

    function onLoadCharacterJsonComplete(event:Event) {
        _file.removeEventListener(Event.COMPLETE, onLoadCharacterJsonComplete);
        
        try {
            var jsonData = _file.data.readUTFBytes(_file.data.length);
            var characterData = Json.parse(jsonData);

            remove(character);

            characterToEdit = characterData.name;
            character = new Character(characterToEdit, 0, 0, false);
            character.characterData = characterData;
            character.playAnim("idle", true);
            character.screenCenter();
            add(character);

            loadCharacterData();
            
            trace("Successfully loaded character: " + characterToEdit);
        } catch (e:Dynamic) {
            trace("Error loading character JSON: " + e);
            // Show error message to user
            #if sys
            Sys.println("Failed to load character: " + e);
            #end
        }
    }

    function saveCharacterData() {
        if (character.characterData == null) return;
        
        // Update character data
        character.characterData.name = characterNameField.text;
        character.characterData.assetsPath = assetsPathField.text;
        character.characterData.icon = iconField.text;
        character.characterData.color = colorField.text;
        
        // Update current animation data
        if (currentAnimationIndex >= 0 && currentAnimationIndex < character.characterData.animations.length) {
            var animData = character.characterData.animations[currentAnimationIndex];
            animData.name = animNameField.text;
            animData.animPrefix = animPrefixField.text;
            animData.animOffset = [Std.int(offsetXStepper.value), Std.int(offsetYStepper.value)];
            animData.frameRate = Std.int(frameRateStepper.value);
            animData.looped = loopedCheckbox.selected;
            
            // Update the animation in the character
            character.animation.remove(animData.name);
            character.animation.addByPrefix(animData.name, animData.animPrefix, animData.frameRate, animData.looped);
            character.animOffset.set(animData.name, animData.animOffset);
        }
        
        // Save to file
        try {
            var data:String = Json.stringify(character.characterData, null, '\t');
            if ((data != null) && (data.length > 0)) {
                _file = new FileReference();
                _file.save(data.trim(), characterToEdit + ".json");
                trace("Character saved successfully: " + characterToEdit + ".json");
            }
        } catch (e:Dynamic) {
            trace("Error saving character: " + e);
            #if sys
            Sys.println("Failed to save character: " + e);
            #end
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.justPressed.BACK) {
            WindowManager.instance.closeWindow(window);
            FlxG.switchState(() -> new PlayState());
        }

        // Test animations with keyboard
        if (character != null)
        {
            if (controls.justPressed.GAME_LEFT) character.playAnim("singLEFT", true);
            if (controls.justPressed.GAME_RIGHT) character.playAnim("singRIGHT", true);
            if (controls.justPressed.GAME_DOWN) character.playAnim("singDOWN", true);
            if (controls.justPressed.GAME_UP) character.playAnim("singUP", true);

            if (controls.justPressed.UI_LEFT) camera.x -= (FlxG.keys.justPressed.SHIFT ? 10 : 1);
            if (controls.justPressed.UI_DOWN) camera.y += (FlxG.keys.justPressed.SHIFT ? 10 : 1);
            if (controls.justPressed.UI_UP) camera.y -= (FlxG.keys.justPressed.SHIFT ? 10 : 1);
            if (controls.justPressed.UI_RIGHT) camera.x += (FlxG.keys.justPressed.SHIFT ? 10 : 1);
        
            character.animation.onFinish.add(function (animName:String) {
                if (animName.startsWith('sing')) {
                    character.animation.play("idle", true);
                }
            });
        }
    }
}