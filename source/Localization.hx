package;

#if sys
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxG;
import haxe.Json;

/**
 * A simple localization system.
 * Probably better than Firetongue.
 * Please credit me if you use it!
 * @author Joalor64GH
 */

class Localization 
{
    /**
     * Contains data for different languages.
     * The outer map's key represent the language code, and the inner map contains the key-value pairs for localized strings.
     */
    private static var data:Map<String, Map<String, String>>;

    private static var currentLanguage:String; // Stores the currently selected language
    private static var DEFAULT_LANGUAGE:String = "en-us"; // The default language (English)

    /**
     * Simply loads languages based on an array of codes.
     * @param languages An array containing the language codes (Example: ["en-us", "es-es", "fr-fr"])
     * @return Whether or not all languages were successfully loaded.
     */

    public static function loadLanguages(languages:Array<String>):Bool
    {
        var allLoaded:Bool = true;

        data = new Map<String, Map<String, String>>();

        for (language in languages) {
            var languageData:Map<String, String> = loadLanguageData(language);
            if (languageData != null && !languageData.isEmpty()) {
                trace("successfully loaded language: " + language + "!");
                data.set(language, languageData);
            } else {
                trace("oh no! failed to load language: " + language + "!");
                allLoaded = false;
            }
        }

        return allLoaded;
    }

    /**
     * Loads the data for the specified language, but falls back to English if it's not found.
     * @param language The language code (Example: "en-us" for English).
     * @return The map containing the parsed data.
     */

    private static function loadLanguageData(language:String):Map<String, String>
    {
        var jsonContent:String;
        var path:String = Paths.file("languages/" + language + ".json");

        // Attempt to load the requested file
        if (FileSystem.exists(path)) {
            // Use the requested language if the file is found
            jsonContent = File.getContent(path);
            currentLanguage = language; // Updates current language to the requested one
        } else {
            // If the requested file is not found, uses the default language as a fallback
            trace("oops! file not found for: " + language + "!");
            jsonContent = File.getContent(Paths.file("languages/" + DEFAULT_LANGUAGE + ".json"));
            currentLanguage = DEFAULT_LANGUAGE;
        }

        return Json.parse(jsonContent);
    }

    /**
     * Used to switch languages to a specified code.
     * @param newLanguage The new language to switch to.
     * @return Whether or not the switch was successful.
     */

    public static function switchLanguage(newLanguage:String):Bool
    {
        // Check if requested language is the same as the current language 
        if (newLanguage == currentLanguage) {
            trace("hey! you're already using the language: " + newLanguage);
            return true; // Language is already selected, so no change is needed
        }

        // Attempt to load data for requested language
        var languageData:Map<String, String> = loadLanguageData(newLanguage);

        // Check if the data was successfully loaded
        if (languageData != null && !languageData.isEmpty()) {
            trace("yay! successfully loaded data for: " + newLanguage);
            currentLanguage = newLanguage; // Updates current language
            return true; // The switch was successful
        } else {
            trace("whoops! failed to load data for: " + newLanguage);
            return false;
        }

        return false;
    }

    /**
     * Retrieves a localized string for a given key and language.
     * @param key The key for the localized string.
     * @param language The language to retrieve the string from.
     * @return The localized string if available, otherwise, returns the key itself if not found.
     */

    public static function get(key:String, language:String = "en-us"):String
    {
        var targetLanguage:String = language.toLowerCase();

        if (data != null && data.exists(targetLanguage)) {
            var languageData = data.get(targetLanguage);
            if (languageData != null && languageData.exists(key)) {
                return languageData.get(key);
            }
        }

        return key; // Returns the key itself
    }
}