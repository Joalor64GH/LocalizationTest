#if sys
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxG;
import haxe.Json;

class Localization 
{
    private static var data:Map<String, Map<String, String>>;
    private static var currentLanguage:String = "en-us";

    public static function loadLanguages(languages:Array<String>):Void 
    {
        data = new Map<String, Map<String, String>>();

        for (language in languages) {
            var languageData:Map<String, String> = loadLanguage(language);
            if (languageData != null) {
                data.set(language, languageData);
            }
        }
    }

    private static function loadLanguage(language:String):Map<String, String>
    {
        var languageData:Map<String, String> = new Map<String, String>();
        var path:String = Paths.locale(language);

        if (FileSystem.exists(path)) {
            var jsonContent:String = File.getContent(path);
            return Json.parse(jsonContent);
        } else {
            trace("oops! file not found for" + language + "!");
        }

        return null;
    }

    public static function switchLanguage(language:String)
    {
        if (data.exists(language)) {
            currentLanguage = language;
        } else {
            trace("oops!" + language + "isn't available!");
        }
    }

    public static function get(key:String):String
    {
        var languageData:Map<String, String> = data.get(currentLanguage);
        if (languageData != null && languageData.exists(key)) {
            return languageData.get(key);
        }

        return "Umm.. We didnt find" + key;
    }
}