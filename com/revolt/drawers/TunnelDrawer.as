﻿package com.revolt.drawers {
	import flash.display.BitmapData;
	import com.revolt.drawers.Drawer;
	import com.revolt.effects.Blur;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
		
public class TunnelDrawer extends Drawer {
		private var z:Number = 0;
		private var blur:Blur;
		
		function TunnelDrawer() {
			super();
			blur = new Blur(3,3);
		}
		
		override public function drawGFX(gfx:BitmapData, soundArray:Array):void {
			for (var i:uint = 0; i < soundArray.length; i++) {
				var l : Number = soundArray[i];
				gfx.setPixel(Math.sin(i/(soundArray.length/2)*Math.PI)*40*l + Math.sin(z)*40 + gfx.width/2, Math.cos(i/(soundArray.length/2)*Math.PI)*40*l + Math.cos(z)*40 + gfx.height/2, 0x0099FF|(l*360 << 8));
				if (l > 0.5) gfx.setPixel(Math.sin(i/256*Math.PI)*40*l + Math.sin(z)*40 + gfx.width/2 + Math.random()*10-5, Math.cos(i/(soundArray.length/2)*Math.PI)*40*l + Math.cos(z)*40 + gfx.height/2 + Math.random()*10-5, 0xffffff);
			}
			z += 0.015;	
			blur.applyFX(gfx);
		}
	}
}