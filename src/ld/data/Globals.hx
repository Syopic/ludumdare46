package ld.data;

class Globals {
    public static var SCALE_FACTOR:Float = 4;
    public static var STAGE_WIDTH:Int = 160;
    public static var STAGE_HEIGHT:Int = 144;

    public static var COLOR_SET = {
		Transparent: 16777215,
		Clear: 0x00000000,
		White: 0xffffffff,
		SpringRain: 0xffc4cfa1,
		Como: 0xff8b956d,
		TimberGreen: 0xff4d533c,
		Aztec: 0xff1f1f1f
	}

	public static var MUSIC_SET = {
		TitleTheme: "track1"
	}

	public static var SFX_SET = {
		UIHover: "uiHov",
		Transition: "transition",
		Test1: "test",
		Test2: "t2"
	}

	public static inline var TITLE_SCREEN = "titleScreen";
	public static inline var CREDITS_SCREEN = "creditsScreen";
	public static inline var GAMEOVER_SCREEN = "gameoverScreen";
}