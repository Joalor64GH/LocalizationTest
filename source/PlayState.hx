package;

import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;

import Localization;

class PlayState extends FlxState
{
    override public function create()
    {
        Localization.loadLanguages(Paths.file('languages'));

        var greetingText = Localization.getText('greeting');

        var daText:FlxText = new FlxText(0, 0, 0, greetingText, 12);
        daText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText.screenCenter(XY);
        add(daText);

        var english:FlxButton = new FlxButton(15, 40, 'English', () -> 
        {
            Localization.switchToLanguage('en-US');
            daText.text = Localization.getLocalizedText('greeting');
        });
        english.label.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        english.label.screenCenter(XY);
        english.scale.set(1.5, 1.5);
        add(english);

        var spanish:FlxButton = new FlxButton(15, english.y + 50, 'Spanish', () -> 
        {
            Localization.switchToLanguage('es-ES');
            daText.text = Localization.getLocalizedText('greeting');
        });
        spanish.label.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        spanish.label.screenCenter(XY);
        spanish.scale.set(1.5, 1.5);
        add(spanish);

        var french:FlxButton = new FlxButton(15, spanish.y + 50, 'French', () -> 
        {
            Localization.switchToLanguage('fr-FR');
            daText.text = Localization.getLocalizedText('greeting');
        });
        french.label.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        french.label.screenCenter(XY);
        french.scale.set(1.5, 1.5);
        add(french);

        var portBrazil:FlxButton = new FlxButton(15, french.y + 50, 'Portuguese (Brazil)', () -> 
        {
            Localization.switchToLanguage('pt-BR');
            daText.text = Localization.getLocalizedText('greeting');
        });
        portBrazil.label.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        portBrazil.label.screenCenter(XY);
        portBrazil.scale.set(1.5, 1.5);
        add(portBrazil);

        var pirate:FlxButton = new FlxButton(15, portBrazil.y + 50, 'Pirate Speak', () -> 
        {
            Localization.switchToLanguage('yr-HR');
            daText.text = Localization.getLocalizedText('greeting');
        });
        pirate.label.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        pirate.label.screenCenter(XY);
        pirate.scale.set(1.5, 1.5);
        add(pirate);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}