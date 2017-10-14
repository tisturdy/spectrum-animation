package com.revolt.presets {
	import com.revolt.presets.Preset;
	import com.revolt.drawers.*;
	import com.revolt.effects.*;
	import com.revolt.scalers.*;
	
	public class Tunnel extends Preset {
		
		function Tunnel() {
			super();
			drawers = new Array(new TunnelDrawer());
			scalers = new Array(new ZoomIn());
			var perlin:Perlin = new Perlin(10,10);
			perlin.interval = 3748;
			effects = new Array(perlin);
		}
		
		override public function toString():String {
			return "Smooth line without fourier transformation";
		}
	}
}