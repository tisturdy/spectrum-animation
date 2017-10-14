package com.revolt.drawers {
	import flash.geom.*;
	import flash.display.*;
	//import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import com.revolt.drawers.Drawer;
	
	public class Exploder extends Drawer {
		private var pos:Number = 0;
		private var lineSprite:Sprite;
		
		function Exploder() {
			super();
			lineSprite = new Sprite();
			fourier =true;
		}
		
		
		
		override public function drawGFX(gfx:BitmapData, soundArray:Array):void {
			 const top_color:uint = 0xffffff;
		//中间颜色
		 const middle_color:uint =  0x8cdcff;//FF8247
		//底部颜色
		 const bottom_color:uint = 0x07f7ff;
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [top_color, middle_color, bottom_color];
			var alphas:Array = [1, 1, 1];
			var ratios:Array = [0x00, 0x7f, 0xff];
			var size:Number = gfx.height*0.9;
			lineSprite.graphics.clear();//#FF0000 #FF4500 #FFFF00
			//lineSprite.graphics.beginFill(0xEE0000);
			lineSprite.graphics.beginGradientFill(fillType, colors, alphas, ratios);
			lineSprite.graphics.moveTo(-Math.sin(0)*2 + gfx.width/2 + gfx.width/8*Math.sin(pos), Math.cos(0) + gfx.height*0.65 + gfx.height/8*Math.cos(pos/2))
			for (var i in soundArray) {
				var lev:Number = soundArray[i];
				var a:uint = i;
//lineSprite.graphics.lineStyle(1, 0x996600|(lev*360 << 8));
				if (i < soundArray.length/2) a += soundArray.length/2;
				var l:Number = Math.ceil((size/2)*(lev+0.5));
				var xPos:Number = -Math.sin(i/(soundArray.length/2)*Math.PI)*l*lev*2+ gfx.width/2+ gfx.width/8*Math.sin(pos);
				var yPos:Number = Math.cos(a/(soundArray.length/2)*Math.PI)*l*lev /2+ gfx.height*0.65+ gfx.height/8*Math.cos(pos/2);
				lineSprite.graphics.lineTo(xPos,yPos);
			}
			lineSprite.graphics.endFill();
			gfx.draw(lineSprite, null, null, "screen", null, true);
			pos += 0.01;
		}
	}
}