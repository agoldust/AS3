package com.alborzsoft.UI
{
	import com.flashdynamix.motion.Tweensy;
	import com.flashdynamix.motion.TweensyTimeline;
	
	import fl.motion.easing.Sine;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class FlipCard3D
	{
		private var zoomTime:Number;
		private var flipTime:Number;
		
		private var zoomBack:Number;
		private var zoomResult:Number;
		
		private var container:MovieClip;

		
		
		
		/** Constructor of 3D Flip Card Class
		 * @param front - DisplayObject of Front of Card
		 * @param back - DisplayObject of back of Card
		 * @param dpContainer - MovieClip that you wants to add the 3D Flip Card to
		 * @param zoomTime - Number of Seconds that indicates Zoom time
		 * @param flipTime - Number of Seconds that indicates Flip time
		 * @param zoomBack - Z property of card ar normal position
		 * @param zoomResult - Z property of card at zoom position
		 * 
		 * 
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 10.0
		 */
		public function FlipCard3D(front:DisplayObject, back:DisplayObject, dpContainer:MovieClip, zoomTime:Number=0.5, flipTime:Number=1.5, zoomBack:Number=300, zoomResult:Number=200, enableMouseEvent:Boolean=true)
		{
			// setting the private properties of this class
			this.zoomTime = zoomTime;
			this.flipTime = flipTime;
			this.zoomBack = zoomBack;
			this.zoomResult = zoomResult;
			
			// hiding the back object
			back = back;
			back.visible = false;
			back.rotationY = 180;
			
			// adding the fornt and back object to main container
			container = dpContainer;
			container.z = zoomBack;
			container.addChildAt(back, 0);
			container.addChildAt(front, 1);
			
			if(enableMouseEvent){
				container.addEventListener(MouseEvent.MOUSE_DOWN,
					function():void	{
						flipSelf(dpContainer)
					});
			}
		}
		
		/** Flip the MovieClip */
		public function flip():void
		{
			flipSelf(container);
		}
								
		
		// fliping the Container
		public function flipSelf(self:MovieClip):void
		{
			var toRot:int = (self.rotationY > 89) ? toRot = 0 : toRot = 180;
			
			Tweensy.to(self, {z:zoomResult}, zoomTime, Sine.easeOut);		// for move forward
			Tweensy.to(self, {z:zoomBack}, zoomTime, Sine.easeIn, flipTime+zoomTime);  // for move backward
			
			var twtl:TweensyTimeline =	Tweensy.to(self, {rotationY:toRot}, flipTime, Sine.easeInOut, zoomTime);  // for rotation
			twtl.onUpdate = setFlipSide;
			twtl.onUpdateParams = [self];
		}
		
		// change the side
		private function setFlipSide(con:MovieClip):void
		{
			if(con.rotationY > 89){
				con.getChildAt(1).visible = false;
				con.getChildAt(0).visible = true;
			}else{
				con.getChildAt(0).visible = false;
				con.getChildAt(1).visible = true;
			}
		}
		
		
	}
}