//author:tisturdy
package com{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.utils.ByteArray;
	import flash.media.*;
	public class ScrollingPerlinNoise extends Sprite {
		public var cloudsWidth:int;
		private var displayHeight:Number;
		private var horizPastePoint:Point;
		private var displayWidth:Number;
		public var cloudsHeight:int;
		private var origin:Point;
		private var grayScale:Boolean;
		private var cloudsBitmap:Bitmap;
		private var cornerCutRect:Rectangle;
		public var periodX:Number;
		public var periodY:Number;
		private var cmf:ColorMatrixFilter;
		public var skyColor:uint;
		private var vertPastePoint:Point;
		private var sliceDataCorner:BitmapData;
		private var vertCutRect:Rectangle;
		public var numOctaves:int;
		private var cloudsMask:Shape;
		private var sliceDataH:BitmapData;
		private var seed:int;
		private var cornerPastePoint:Point;
		public var scrollAmountX:int;
		public var scrollAmountY:int;
		public var cloudsBitmapData:BitmapData;
		private var colorBackground:Shape;
		private var horizCutRect:Rectangle;
		private var sliceDataV:BitmapData;
         public var bytes:ByteArray=new ByteArray();
		
		
		public function ScrollingPerlinNoise(param1:int = 300, param2:int = 200, param3:int = 0, param4:int = -4, param5:Boolean = true, param6:uint = 0, param7:Number = 5, param8:Number = 150, param9:Number = 150, param10:Boolean = true) {
			//var bytes:ByteArray=new ByteArray();
			SoundMixer.computeSpectrum(bytes,false);
			var lev=bytes.readFloat();

			this.displayWidth=param1+500*lev;
			this.displayHeight=param2+400*lev;
			this.cloudsWidth=this.displayWidth;
			this.cloudsHeight=this.displayHeight;
			this.periodX=param8;
			this.periodY=param9;
			this.scrollAmountX=param3;
			this.scrollAmountY=param4;
			this.grayScale=param10;
			this.numOctaves=param7;
			this.skyColor=param6;
			this.cloudsBitmapData=new BitmapData(this.cloudsWidth,this.cloudsHeight,true);
			this.cloudsBitmap=new Bitmap(this.cloudsBitmapData);
			this.origin=new Point(0,0);
			if (param5) {
				this.colorBackground = new Shape();
				this.colorBackground.graphics.beginFill(0x00000);
				this.colorBackground.graphics.drawRect(0, 0, this.displayWidth, this.displayHeight);
				this.colorBackground.graphics.endFill();
				this.addChild(this.colorBackground);
			}
			this.addChild(this.cloudsBitmap);
			this.makeClouds();
			this.setRectangles();



			return;
		}// end function

		public function makeClouds():void {
			

			this.seed=int(Math.random()*16777215);
			if (this.grayScale) {
				this.cloudsBitmapData.perlinNoise(this.periodX, this.periodY, this.numOctaves, this.seed, true, true, 1, true);
			} else {
				this.cloudsBitmapData.perlinNoise(this.periodX, this.periodY, this.numOctaves, this.seed, true, true, 7, false);
			}
			var _loc_1:* =new ColorMatrixFilter([1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0]);
			this.cloudsBitmapData.applyFilter(this.cloudsBitmapData, this.cloudsBitmapData.rect, new Point(), _loc_1);
			return;
		}// end function

		private function onEnter(event:Event):void {
			this.cloudsBitmapData.lock();
			if (this.scrollAmountX!=0) {
				this.sliceDataV.copyPixels(this.cloudsBitmapData, this.vertCutRect, this.origin);
			}
			if (this.scrollAmountY!=0) {
				this.sliceDataH.copyPixels(this.cloudsBitmapData, this.horizCutRect, this.origin);
			}
			if (this.scrollAmountX!=0&&this.scrollAmountY!=0) {
				this.sliceDataCorner.copyPixels(this.cloudsBitmapData, this.cornerCutRect, this.origin);
			}
			this.cloudsBitmapData.scroll(this.scrollAmountX, this.scrollAmountY);
			if (this.scrollAmountX!=0) {
				this.cloudsBitmapData.copyPixels(this.sliceDataV, this.sliceDataV.rect, this.vertPastePoint);
			}
			if (this.scrollAmountY!=0) {
				this.cloudsBitmapData.copyPixels(this.sliceDataH, this.sliceDataH.rect, this.horizPastePoint);
			}
			if (this.scrollAmountX!=0&&this.scrollAmountY!=0) {
				this.cloudsBitmapData.copyPixels(this.sliceDataCorner, this.sliceDataCorner.rect, this.cornerPastePoint);
			}
			this.cloudsBitmapData.unlock();
			return;
		}// end function

		public function startScroll():void {
			this.addEventListener(Event.ENTER_FRAME, this.onEnter);
			return;
		}// end function

		private function setRectangles():void {
			
			if (this.scrollAmountX!=0) {
				this.sliceDataV=new BitmapData(Math.abs(this.scrollAmountX),this.cloudsHeight-Math.abs(this.scrollAmountY),true);
			}
			if (this.scrollAmountY!=0) {
				this.sliceDataH=new BitmapData(this.cloudsWidth,Math.abs(this.scrollAmountY),true);
			}
			if (this.scrollAmountX!=0&&this.scrollAmountY!=0) {
				this.sliceDataCorner=new BitmapData(Math.abs(this.scrollAmountX),Math.abs(this.scrollAmountY),true);
			}
			this.horizCutRect=new Rectangle(0,this.cloudsHeight-this.scrollAmountY,this.cloudsWidth-Math.abs(this.scrollAmountX),Math.abs(this.scrollAmountY));
			this.vertCutRect=new Rectangle(this.cloudsWidth-this.scrollAmountX,0,Math.abs(this.scrollAmountX),this.cloudsHeight-Math.abs(this.scrollAmountY));
			this.cornerCutRect=new Rectangle(this.cloudsWidth-this.scrollAmountX,this.cloudsHeight-this.scrollAmountY,Math.abs(this.scrollAmountX),Math.abs(this.scrollAmountY));
			this.horizPastePoint=new Point(this.scrollAmountX,0);
			this.vertPastePoint=new Point(0,this.scrollAmountY);
			this.cornerPastePoint=new Point(0,0);
			if (this.scrollAmountX<0) {
				var _loc_1:int=0;
				this.vertCutRect.x=0;
				this.cornerCutRect.x=_loc_1;
				var _loc_1:* =this.cloudsWidth+this.scrollAmountX;
				this.vertPastePoint.x=20;
				this.cornerPastePoint.x=_loc_1;
				this.horizCutRect.x=- this.scrollAmountX;
				this.horizPastePoint.x=0;
			}
			if (this.scrollAmountY<0) {
				var _loc_1:int=0;
				this.horizCutRect.y=0;
				this.cornerCutRect.y=_loc_1;
				var _loc_1:* =this.cloudsHeight+this.scrollAmountY;
				this.horizPastePoint.y=this.cloudsHeight+this.scrollAmountY;
				this.cornerPastePoint.y=_loc_1;
				this.vertCutRect.y=- this.scrollAmountY;
				this.vertPastePoint.y=0;
			}
			return;
		}// end function

		public function stopScroll():void {
			this.removeEventListener(Event.ENTER_FRAME, this.onEnter);
			return;
		}// end function

	}
}
