﻿package com.revolt.effects {
	import flash.display.BitmapData;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	import com.revolt.effects.Effect;
	
	public class Perlin extends Effect {
		static private var noiseMaps:Array;
		private var noiseMap:BitmapData;
		private var noiseInt:Timer;
		private var xVal:Number;
		private var yVal:Number;
		private var _displaceMode:String;
		private var perlinCount:uint = 5;
		
		function Perlin(xStrength:Number = 20, yStrength:Number = 20, displaceMode:String = "clamp") {
			super();
			xVal = xStrength;
			yVal = yStrength;
			_displaceMode = displaceMode;
		}
		
		public function set interval(newInterval:Number):void {
			if (noiseInt) noiseInt.stop();
			noiseInt = new Timer(newInterval, 0);
			noiseInt.addEventListener(TimerEvent.TIMER, remapNoise);
			noiseInt.start();
			remapNoise(null);
		}
		
		override public function applyFX(gfx:BitmapData):void {
			if (!noiseMaps) {
				noiseMaps = new Array();
				for (var i:uint = 0; i < perlinCount; i++) {
					var map:BitmapData = new BitmapData(gfx.width, gfx.height, false, 0x808080);
					map.perlinNoise(100, 40, 3, Math.random()*100, false, true, 1, true);
					noiseMaps.push(map);
				}
				interval = 937; // ms
			}
			var displace:DisplacementMapFilter = new DisplacementMapFilter(noiseMap, new Point(0, 0), 1, 2, xVal, yVal);
			displace.mode = _displaceMode;
			gfx.applyFilter(gfx, new Rectangle(0, 0, gfx.width, gfx.height), new Point(0, 0), displace);			
		}
		
		private function remapNoise(ev:TimerEvent):void {
			if (noiseMaps) {
				var index:uint = Math.floor(Math.random()*perlinCount);
				noiseMap = noiseMaps[index];
			}
		}
	}
}