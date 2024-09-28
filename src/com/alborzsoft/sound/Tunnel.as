package com.alborzsoft.sound {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	public class Tunnel {
		private var s:Sound = new Sound();
		private var sc:SoundChannel = new SoundChannel();
		private var ba:ByteArray = new ByteArray();
		private var gfx:BitmapData;
		private var gfx2:BitmapData;
		private var pic:Bitmap;	
		private var noiseMap:BitmapData;
		private var noiseInt:Timer;
		private var ___width:uint;
		private var ___height:uint;		
		private var z:Number = 0;
		private var dir:int;
		private var xPos:int;
		
		function Tunnel(hostMC:MovieClip, __width:Number, __height:Number) {
			___width = __width;
			___height = __height;
			
			gfx =  new BitmapData(__width, __height, false, 0x000000);
			gfx2 = gfx.clone();
			pic = new Bitmap(gfx)
			hostMC.addChild(pic);
			
			noiseMap = new BitmapData(__width, __height, false, 0xffffff);
			
			noiseInt = new Timer(2000, 0);
			noiseInt.addEventListener(TimerEvent.TIMER, remapNoise);
			noiseInt.start();
			remapNoise(null);
			
			hostMC.addEventListener(Event.ENTER_FRAME, processSpectrum);
		}
		
		private function processSpectrum(ev:Event):void {
			var l:Number;
			SoundMixer.computeSpectrum(ba, true, 0);
			var values:Array = new Array();
			for (var i:uint = 0; i < 512; i++) {
				l = ba.readFloat();
				gfx.setPixel(Math.sin(i/256*Math.PI)*40*l + Math.sin(z)*40 + ___width/2, Math.cos(i/256*Math.PI)*40*l + Math.cos(z)*40 + ___height/2, 0x0099FF|(l*360 << 8));
				if (l > 0.5) gfx.setPixel(Math.sin(i/256*Math.PI)*40*l + Math.sin(z)*40 + ___width/2 + Math.random()*10-5, Math.cos(i/256*Math.PI)*40*l + Math.cos(z)*40 + ___height/2 + Math.random()*10-5, 0xffffff);
			}
			z += 0.02;			
			
			var trans:Matrix = new Matrix();
			var scale:Number = 1.1;
			trans.scale(scale, scale);
			var offset:Number = -(scale-1)/2;
			trans.translate(offset*___width,offset*256);
			gfx2.draw(gfx, trans);
			
			gfx.draw(gfx2);
			var blur:BlurFilter = new BlurFilter(3,3);
			gfx.applyFilter(gfx, new Rectangle(0, 0, ___width, ___height), new Point(0, 0), blur);
			var displace:DisplacementMapFilter = new DisplacementMapFilter(noiseMap, new Point(0, 0), 1, 2, 20, 20);
			displace.mode = "clamp";
			gfx.applyFilter(gfx, new Rectangle(0, 0, ___width, ___height), new Point(0, 0), displace);
		}
		
		private function remapNoise(ev:TimerEvent):void {
			noiseMap.perlinNoise(100, 40, 3, int(Math.random()*100), false, true,7, true, null);
		}
	}
}