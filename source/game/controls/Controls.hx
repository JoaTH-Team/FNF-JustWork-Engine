package game.controls;

import flixel.addons.input.FlxControls;
import flixel.input.keyboard.FlxKey;

enum Action {
    GAME_UP;
    GAME_DOWN;
    GAME_LEFT;
    GAME_RIGHT;

    UI_UP;
    UI_DOWN;
    UI_LEFT;
    UI_RIGHT;

    ACCEPT;
    BACK;
}

class Controls extends FlxControls<Action> {
    function getDefaultMappings():ActionMap<Action> {
        return [
            Action.GAME_UP => [FlxKey.fromString("W"), FlxKey.fromString("UP")],
            Action.GAME_DOWN => [FlxKey.fromString("S"), FlxKey.fromString("DOWN")],
            Action.GAME_LEFT => [FlxKey.fromString("A"), FlxKey.fromString("LEFT")],
            Action.GAME_RIGHT => [FlxKey.fromString("D"), FlxKey.fromString("RIGHT")],

            Action.UI_UP => [FlxKey.fromString("W"), FlxKey.fromString("UP")],
            Action.UI_DOWN => [FlxKey.fromString("S"), FlxKey.fromString("DOWN")],
            Action.UI_LEFT => [FlxKey.fromString("A"), FlxKey.fromString("LEFT")],
            Action.UI_RIGHT => [FlxKey.fromString("D"), FlxKey.fromString("RIGHT")],

            Action.ACCEPT => [FlxKey.fromString("ENTER"), FlxKey.fromString("SPACE")],
            Action.BACK => [FlxKey.fromString("ESCAPE"), FlxKey.fromString("BACKSPACE")],
        ];
    }
}