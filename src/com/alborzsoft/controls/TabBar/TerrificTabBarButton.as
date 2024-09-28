package com.alborzsoft.controls.TabBar {
	import com.alborzsoft.controls.TabBar.events.TerrificTabBarEvent;
	import com.alborzsoft.controls.TabBar.skins.TerrificTabBarButtonSkin;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	
	import spark.components.Button;
	import spark.components.ButtonBarButton;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.TextInput;
	
	[Event(name='closeTab',type='events.TerrificTabBarEvent')]
	
	public class TerrificTabBarButton extends ButtonBarButton 
	{
		[SkinPart(required="false")]
		public var closeButton:Button;
		
		[SkinPart(required="false")]
		public var img_icon:Image;
		
		[SkinPart(required="false")]
		public var header_Display:spark.components.TextInput;
		
		private var _closeable:Boolean = true;
		
		private var _closebtnX:Number = 0;

		private var _iconvisible:Boolean = true;
		
		private var _headervisible:Boolean = true;
		
		
		public function TerrificTabBarButton() 
		{
			super();

			//NOTE: this enables the button's children (aka the close button) to receive mouse events
			this.mouseChildren = true;
			
			// setting style
			super.setStyle('fontSize', 12);
			super.setStyle('skinClass', TerrificTabBarButtonSkin);
		}

		[Bindable]
		public function get closebtnX():Number{
			return _closebtnX;
		}
		
		public function set closebtnX(val:Number):void{
			_closebtnX = val;
			closeButton.x = val;
			
		}
		
		[Bindable]
		public function get closeable():Boolean {
			return _closeable;
		}
		
		public function set closeable(val:Boolean):void
		{
			if (_closeable != val) {
				_closeable = val;
				closeButton.visible = val;
				closeButton.includeInLayout = val;
				//labelDisplay.right = (val ? 30 : 14);
			}
		}
		
		//Added by Dhwani - for getting value of icon image visible
		[Bindable]
		public function get IconVisible():Boolean {
			return _iconvisible;
		}

		//Added by Dhwani - for setting icon image visible true/false
		public function set IconVisible(val:Boolean):void
		{
			if(_iconvisible != val){
				_iconvisible = val;
				img_icon.visible = val;
				img_icon.includeInLayout = val;
				
			}
		}
		
		[Bindable]
		public function get HeaderVisible():Boolean {
			return _headervisible;
		}
		
		public function set HeaderVisible(val:Boolean):void
		{
			if(_headervisible != val){
				_headervisible = val;
				header_Display.visible = val;
				header_Display.includeInLayout = val;
				
			}
		}
	
		private function closeHandler(e:MouseEvent):void {
			dispatchEvent(new TerrificTabBarEvent(TerrificTabBarEvent.CLOSE_TAB, itemIndex, true));
		}

		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == closeButton) {
				closeButton.addEventListener(MouseEvent.CLICK, closeHandler);
				closeButton.visible = closeable;
				
			} else if (instance == labelDisplay) {
				//labelDisplay.right = (closeable ? 30 : 14);
			}
		}

		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == closeButton) {
				closeButton.removeEventListener(MouseEvent.CLICK, closeHandler);
			}
		}
	}
}