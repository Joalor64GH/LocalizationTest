import openfl.utils.Assets;
import flixel.FlxG;
import haxe.Json;

class Localization 
{
    public static var currentLanguage:String = "en-US";
    public static var texts:Map<String, Map<String, String>> = {};

    public static function loadLanguage(language:String, jsonPath:String):Void 
    {
        // Load JSON file
        var jsonString = Assets.getText(jsonPath); 

        // Parse JSON data
        var languageMap:Map<String, String> = Json.parse(jsonString);

        // Store language data
        texts.set(language, languageMap);
    }

    public static function getText(key:String):String 
    {
        var languageMap = texts.get(currentLanguage);
        if (languageMap != null) {
            return languageMap.get(key);
        }
        trace('oops! it returned null!');
        return null;
    }

    public static function switchToLanguage(language:String)
    {
        if (texts.exists(language)) {
            currentLanguage = language;
        } else {
            trace('sorry! $language isnt supported!')
        }
    }

    public static function getLocalizedText(key:String)
    {
        var text:String = getText(key);
        if (text == 'oops! it returned null!') {
            trace('$key doesnt exist. sorry!');
            return 'oops! it returned null!';
        }
        return text;
    }
}