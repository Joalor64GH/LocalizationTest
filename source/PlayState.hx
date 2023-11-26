package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import Localization;

class PlayState extends FlxState
{
    var daText:FlxText;
    var daText2:FlxText;

    var font:String;

    var greeting:String = Localization.get("greeting");
    var instructions:String = Localization.get("instructions");

    override public function create()
    {
        Localization.loadLanguages(["en-us", "es-es", "fr-fr", "pt-br", "yr-hr", "ru-ru"]);
        Localization.switchLanguage("en-us"); // Default language

        font = Paths.font("vcr.ttf");

        daText = new FlxText(0, 0, 0, greeting, 12);
        daText.setFormat(font, 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText.screenCenter(XY);
        add(daText);

        daText2 = new FlxText(4, FlxG.height - 24, 0, instructions, 12);
        daText2.setFormat(Paths.font("vcr.ttf"), 26, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText2.scrollFactor.set();
        add(daText2);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ONE) {
            Localization.switchLanguage("en-us");
            daText.text = Localization.get('greeting');
            daText2.text = Localization.get('instructions');
            font = Paths.font("vcr.ttf");
        } else if (FlxG.keys.justPressed.TWO) {
            Localization.switchLanguage("es-es");
            daText.text = Localization.get('greeting', 'es-es');
            daText2.text = Localization.get('instructions', 'es-es');
            font = Paths.font("vcr.ttf");
        } else if (FlxG.keys.justPressed.THREE) {
            Localization.switchLanguage("fr-fr");
            daText.text = Localization.get('greeting', 'fr-fr');
            daText2.text = Localization.get('instructions', 'fr-fr');
            font = Paths.font("vcr.ttf");
        } else if (FlxG.keys.justPressed.FOUR) {
            Localization.switchLanguage("pt-br");
            daText.text = Localization.get('greeting', 'pt-br');
            daText2.text = Localization.get('instructions', 'pt-br');
            font = Paths.font("vcr.ttf");
        } else if (FlxG.keys.justPressed.FIVE) {
            Localization.switchLanguage("yr-hr");
            daText.text = Localization.get('greeting', 'yr-hr');
            daText2.text = Localization.get('instructions', 'yr-hr');
            font = Paths.font("vcr.ttf");
        } else if (FlxG.keys.justPressed.SIX) {
            Localization.switchLanguage("ru-ru");
            daText.text = Localization.get('greeting', 'ru-ru');
            daText2.text = Localization.get('instructions', 'ru-ru');
            font = Paths.font("vcrRUS.ttf");
        }
    }
}