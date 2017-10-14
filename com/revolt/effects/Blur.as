﻿package com.revolt.effects {
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.revolt.effects.Effect;
	
	public class Blur extends Effect {
		private var blurX:Number;
		private var blurY:Number;
		private var blurQuality:Number;
		
		function Blur(xBlur:Number = 2, yBlur:Number = 2, quality:Number = 1) {
			blurX = xBlur;
			blurY = yBlur;
			blurQuality = quality;
		}
		
		override public function applyFX(gfx:BitmapData):void {
			var b:BlurFilter = new BlurFilter(blurX, blurY, blurQuality);
			gfx.applyFilter(gfx, new Rectangle(0, 0, gfx.width, gfx.height), new Point(0, 0), b);
		}
	}
}