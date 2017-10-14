﻿package com.revolt.scalers {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import com.revolt.scalers.Scale
	
	public class ZoomOut extends Scale {
		private var gfx2:BitmapData;
		private var _speed:Number;
		
		function ZoomOut(speed:Number = 100) {
			super();
			_speed = speed;
		}
		
		override public function applyScale(gfx:BitmapData):void {
			if (!gfx2) gfx2 = gfx.clone();
			var trans:Matrix = new Matrix();
			var scale:Number = 1-(0.05*_speed/100);
			trans.scale(scale, scale);
			var offset:Number = (1-scale)/2;
			trans.translate(offset*gfx.width,offset*gfx.height);
			gfx2.draw(gfx, trans);
			gfx.draw(gfx2);
		}
	}
}