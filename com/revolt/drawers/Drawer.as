﻿package com.revolt.drawers {
	import flash.display.BitmapData;
	
	public class Drawer {
		private var _fourier:Boolean = true;
		
		function Drawer() {
		}
		
		public function drawGFX(gfx:BitmapData, soundArray:Array):void {
			trace("drawGFX is not defined for " + this);
		}
		
		public function get fourier():Boolean {
			return _fourier;
		}
		
		public function set fourier(newFourier:Boolean):void {
			_fourier = newFourier;
		}
		
		public function init():void {
			
		}
	}
}