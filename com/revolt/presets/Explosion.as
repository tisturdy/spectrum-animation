package com.revolt.presets {
	import com.revolt.presets.Preset;
	import com.revolt.drawers.*;
	import com.revolt.effects.*;
	import com.revolt.scalers.*;
	import flash.display.BitmapData;
	
	public class Explosion extends Preset {
		function Explosion() {
			super();
			fourier = true;
			drawers = new Array(new Exploder());
			effects = new Array(new Blur(3,3), new Perlin(5,4), new Blur(10,6), new Tint(0xff0000, 0.1));
			scalers = new Array(new ZoomIn());
		}
		
		//override public function toString():String {
			//return "Circular explosion";
		//}
	}
}