package game.scripts;

class FunkinScriptVariable
{
    public static var variables:Map<String, Dynamic> = new Map<String, Dynamic>();

    public static function setVariable(name:String, value:Dynamic):Void {
        variables.set(name, value);
    }

    public static function getVariable(name:String):Dynamic {
        return variables.get(name);
    }
}