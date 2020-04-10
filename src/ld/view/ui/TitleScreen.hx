package ld.view.ui;

import h2d.Flow.FlowAlign;
import h2d.Bitmap;
import h2d.Object;

class TitleScreen extends h2d.Object {
	var style:h2d.domkit.Style = null;
	var panelFlow = null;
	var bgImage:Bitmap;

	public function new(parent:Object) {
		super(parent);

		var tile = hxd.Res.img.titleScreen.toTile();
		bgImage = new Bitmap(tile, this);
		// bgImage.setScale(4);


		// var glitchShader = new GlitchShader();

		// glitchShader.color.set(1.0, 0.0, 0.0, 1.0);
		// logoImage.addShader(glitchShader);

		panelFlow = new h2d.Flow(this);
		panelFlow.minWidth = panelFlow.maxWidth = hxd.Window.getInstance().width;
		panelFlow.minHeight = panelFlow.maxHeight = hxd.Window.getInstance().height;
		panelFlow.padding = 10;

		// panelFlow.debug = true;
		// panelFlow.background  =  0xff0000;
		panelFlow.verticalSpacing = 6;
		panelFlow.horizontalAlign = FlowAlign.Right;
		panelFlow.verticalAlign = FlowAlign.Middle;
		panelFlow.layout = Vertical;

		// panelFlow.addChild(new Button(this, "Start", function() {
		// 	Game.instance.start();
		// }));
		// panelFlow.filter = new Glow(Utils.colorFormat(GameConfig.THEME.outline), 1, 4);
		// logoImage.filter = new Glow(Utils.colorFormat(GameConfig.THEME.outline), 1, 4);
		style = new h2d.domkit.Style();
		style.load(hxd.Res.styles.styles);
		// var view = new MenuviewComp(panelFlow);
		// style.addObject(view);
		onResize();
	}

	public function onResize() {
		if (panelFlow != null) {
			var scaleCoef:Float = Math.min(hxd.Window.getInstance().width / 640, hxd.Window.getInstance().height / 576);
			var scaleCoefMax:Float = Math.max(hxd.Window.getInstance().width / 640, hxd.Window.getInstance().height / 576);
			panelFlow.minWidth = panelFlow.maxWidth = hxd.Window.getInstance().width;
			panelFlow.minHeight = panelFlow.maxHeight = hxd.Window.getInstance().height;
			// panelFlow.paddingRight = Std.int(130 * scaleCoefMax);
			// panelFlow.paddingTop = Std.int(180 * scaleCoef);
			// bgImage.setScale(scaleCoef * 4);
		}
	}

	public function update(dt:Float) {
		if (style != null)
			style.sync();
	}
}
