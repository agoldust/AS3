package com.alborzsoft.layouts
{
	import flash.geom.Rectangle;
	
	import mx.core.ILayoutElement;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.supportClasses.GroupBase;
	import spark.core.NavigationUnit;
	import spark.layouts.*;
	import spark.layouts.supportClasses.DropLocation;
	import spark.layouts.supportClasses.LayoutBase;
	
	/**
	 *  The TileLayout class arranges layout elements in columns and rows
	 *  of equally-sized cells.
	 *  The TileLayout class uses a number of properties that control orientation,
	 *  count, size, gap and justification of the columns and the rows
	 *  as well as element alignment within the cells.
	 *
	 *  <p>Per-element supported constraints are 
	 *  <code>percentWidth</code> and <code>percentHeight</code>.
	 *  Element's minimum and maximum sizes are always be respected and
	 *  where possible, an element's size is limited to less then or equal
	 *  of the cell size.</p>
	 *
	 *  <p>When not explicitly set, the <code>columnWidth</code> property 
	 *  is calculated as the maximum preferred bounds width of all elements 
	 *  and the <code>columnHeight</code> property is calculated
	 *  as the maximum preferred bounds height of all elements.</p>
	 *
	 *  <p>When not explicitly set, the <code>columnCount</code> and 
	 *  <code>rowCount</code> properties are calculated from
	 *  any explicit width and height settings for the layout target, 
	 *  and <code>columnWidth</code> and <code>columnHeight</code>.  
	 *  In case none is specified, the <code>columnCount</code> and <code>rowCount</code>
	 *  values are picked so that the resulting pixel area is as square as possible.</p>
	 * 
	 * <p> The measured size is calculated from the <code>columnCount</code>, <code>rowCount</code>, 
	 *  <code>columnWidth</code>, <code>rowHeight</code> properties and the gap sizes.</p>
	 *
	 *  <p>The default measured size, when no properties were explicitly set, is
	 *  as square as possible area and is large enough to fit all elements.</p>
	 *
	 *  <p>In other cases the measured size may not be big enough to fit all elements.
	 *  For example, when both <code>columnCount</code> and <code>rowCount</code> are explicitly set to values
	 *  such that <code>columnCount</code> &#42; <code>rowCount</code> &lt; element count.</p>
	 *
	 *  <p>The minimum measured size is calculated the same way as the measured size but
	 *  it's guaranteed to encompass enough rows and columns along the minor axis to fit
	 *  all elements.</p>
	 *
	 *  @mxml 
	 *  <p>The <code>&lt;s:TileLayout&gt;</code> tag inherits all of the tag 
	 *  attributes of its superclass and adds the following tag attributes:</p>
	 *
	 *  <pre>
	 *  &lt;s:TileLayout 
	 *    <strong>Properties</strong>
	 *    columnAlign="left"
	 *    columnWidth="NaN"
	 *    horizontalAlign="justify"
	 *    horizontalGap="6"
	 *    orientation="rows"
	 *    requestedColumnCount="-1"
	 *    requestedRowCount="-1"
	 *    rowAlign="top"
	 *    rowCount="-1"
	 *    rowHeight="NaN"
	 *    verticalAlign="justify"
	 *    verticalGap="6"
	 *  /&gt;
	 *  </pre>
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public class VariableTileLayout extends LayoutBase
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function VariableTileLayout():void
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  horizontalGap
		//----------------------------------
		
		private var explicitHorizontalGap:Number = 6;
		private var _horizontalGap:Number = 6;
		
		[Bindable("propertyChange")]
		[Inspectable(category="General")]
		
		/**
		 *  Horizontal space between columns, in pixels.
		 *
		 *  @see #verticalGap
		 *  @see #columnAlign
		 *  @default 6
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get horizontalGap():Number
		{
			return _horizontalGap;
		}
		
		/**
		 *  @private
		 */
		public function set horizontalGap(value:Number):void
		{
			explicitHorizontalGap = value;
			if (value == _horizontalGap)
				return;
			
			_horizontalGap = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		//----------------------------------
		//  verticalGap
		//----------------------------------
		
		private var explicitVerticalGap:Number = 6;
		private var _verticalGap:Number = 6;
		
		[Bindable("propertyChange")]
		[Inspectable(category="General")]
		
		/**
		 *  Vertical space between rows, in pixels.
		 *
		 *  @see #horizontalGap
		 *  @see #rowAlign
		 *  @default 6
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get verticalGap():Number
		{
			return _verticalGap;
		}
		
		/**
		 *  @private
		 */
		public function set verticalGap(value:Number):void
		{
			explicitVerticalGap = value;
			if (value == _verticalGap)
				return;
			
			_verticalGap = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		//----------------------------------
		//  columnCount
		//----------------------------------
		
		private var _columnCount:int = -1;
		
		[Bindable("propertyChange")]
		[Inspectable(category="General")]
		
		/**
		 *  Contain the actual column count.
		 *
		 *  @see #rowCount
		 *  @see #columnAlign
		 *  @default -1
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get columnCount():int
		{
			return _columnCount;
		}
		
		//----------------------------------
		//  requestedColumnCount
		//----------------------------------
		
		/**
		 *  @private
		 *  Storage for the requestedColumnCount property.
		 */
		private var _requestedColumnCount:int = -1;
		
		[Inspectable(category="General", minValue="-1")]
		
		/**
		 *  Number of columns to be displayed.
		 * 
		 *  <p>Set to -1 to allow the TileLayout to determine
		 *  the column count automatically.</p>
		 *
		 *  <p>If the <code>orientation</code> property is set to <code>TileOrientation.ROWS</code>, 
		 *  then setting this property has no effect
		 *  In this case, the <code>rowCount</code> is explicitly set, and the
		 *  container width is explicitly set. </p>
		 * 
		 *  @see #columnCount
		 *  @see #columnAlign
		 *  @default -1
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get requestedColumnCount():int
		{
			return _requestedColumnCount;
		}
		
		/**
		 *  @private
		 */
		public function set requestedColumnCount(value:int):void
		{
			if (_requestedColumnCount == value)
				return;
			
			_requestedColumnCount = value;
			_columnCount = value;
			invalidateTargetSizeAndDisplayList();
		}    
		
		//----------------------------------
		//  rowCount
		//----------------------------------
		
		/**
		 *  @private
		 *  Storage for the rowCount property.
		 */
		private var _rowCount:int = -1;
		
		[Bindable("propertyChange")]
		[Inspectable(category="General")]
		
		/**
		 *  The row count.
		 *
		 *  @see #requestedRowCount
		 *  @see #columnCount
		 *  @default -1
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get rowCount():int
		{
			return _rowCount;
		}
		
		//----------------------------------
		//  requestedRowCount
		//----------------------------------
		
		/**
		 *  @private
		 *  Storage for the requestedRowCount property.
		 */
		private var _requestedRowCount:int = -1;
		
		[Inspectable(category="General", minValue="-1")]
		
		/**
		 *  Number of rows to be displayed.
		 * 
		 *  <p>Set to -1 to remove explicit override and allow the TileLayout to determine
		 *  the row count automatically.</p>
		 *
		 *  <p>If the <code>orientation</code> property is set to 
		 *  <code>TileOrientation.COLUMNS</code>, setting this property has no effect.
		 *  in this case, <code>columnCount</code> is explicitly set, and the
		 *  container height is explicitly set.</p>
		 * 
		 *  @see #rowCount
		 *  @see #rowAlign
		 *  @default -1
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get requestedRowCount():int
		{
			return _requestedRowCount;
		}
		
		/**
		 *  @private
		 */
		public function set requestedRowCount(value:int):void
		{
			if (_requestedRowCount == value)
				return;
			
			_requestedRowCount = value;
			_rowCount = value;
			invalidateTargetSizeAndDisplayList();
		}    
		
		//----------------------------------
		//  columnWidth
		//----------------------------------
		
		private var explicitColumnWidth:Number = NaN;
		private var _columnWidth:Number = NaN;
		
		[Bindable("propertyChange")]
		[Inspectable(category="General", minValue="0.0")]
		
		/**
		 *  Contain the actual column width, in pixels.
		 *
		 *  <p>If not explicitly set, the column width is 
		 *  determined from the width of the widest element. </p>
		 *
		 *  <p>If the <code>columnAlign</code> property is set 
		 *  to <code>"justifyUsingWidth"</code>,  the column width grows to the 
		 *  container width to justify the fully-visible columns.</p>
		 *
		 *  @see #rowHeight
		 *  @see #columnAlign
		 *  @default NaN
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get columnWidth():Number
		{
			return _columnWidth;
		}
		
		/**
		 *  @private
		 */
		public function set columnWidth(value:Number):void
		{
			explicitColumnWidth = value;
			if (value == _columnWidth)
				return;
			
			_columnWidth = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		//----------------------------------
		//  rowHeight
		//----------------------------------
		
		private var explicitRowHeight:Number = NaN;
		private var _rowHeight:Number = NaN;
		
		[Bindable("propertyChange")]
		[Inspectable(category="General", minValue="0.0")]
		
		/**
		 *  The row height, in pixels.
		 *
		 *  <p>If not explicitly set, the row height is 
		 *  determined from the maximum of elements' height.</p>
		 *
		 *  If <code>rowAlign</code> is set to "justifyUsingHeight", the actual row height
		 *  increases to justify the fully-visible rows to the container height.
		 *
		 *  @see #columnWidth
		 *  @see #rowAlign
		 *  @default NaN
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get rowHeight():Number
		{
			return _rowHeight;
		}
		
		/**
		 *  @private
		 */
		public function set rowHeight(value:Number):void
		{
			explicitRowHeight = value;
			if (value == _rowHeight)
				return;
			
			_rowHeight = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		//----------------------------------
		//  horizontalAlign
		//----------------------------------
		
		private var _horizontalAlign:String = HorizontalAlign.JUSTIFY;
		
		[Inspectable(category="General", enumeration="left,right,center,justify", defaultValue="justify")]
		
		/**
		 *  Specifies how to align the elements within the cells in the horizontal direction.
		 *  Supported values are
		 *  <code>HorizontalAlign.LEFT</code>,
		 *  <code>HorizontalAlign.CENTER</code>,
		 *  <code>HorizontalAlign.RIGHT</code>,
		 *  <code>HorizontalAlign.JUSTIFY</code>.
		 *
		 *  <p>When set to <code>HorizontalAlign.JUSTIFY</code> the width of each
		 *  element is set to the <code>columnWidth</code>.</p>
		 *
		 *  @default <code>HorizontalAlign.JUSTIFY</code>
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}
		
		/**
		 *  @private
		 */
		public function set horizontalAlign(value:String):void
		{
			if (_horizontalAlign == value)
				return;
			
			_horizontalAlign = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		//----------------------------------
		//  verticalAlign
		//----------------------------------
		
		private var _verticalAlign:String = VerticalAlign.JUSTIFY;
		
		[Inspectable(category="General", enumeration="top,bottom,middle,justify", defaultValue="justify")]
		
		/**
		 *  Specifies how to align the elements within the cells in the vertical direction.
		 *  Supported values are
		 *  <code>VerticalAlign.TOP</code>,
		 *  <code>VerticalAlign.MIDDLE</code>,
		 *  <code>VerticalAlign.BOTTOM</code>,
		 *  <code>VerticalAlign.JUSTIFY</code>.
		 *
		 *  <p>When set to <code>VerticalAlign.JUSTIFY</code>, the height of each
		 *  element is set to <code>rowHeight</code>.</p>
		 *
		 *  @default <code>VerticalAlign.JUSTIFY</code>
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		/**
		 *  @private
		 */
		public function set verticalAlign(value:String):void
		{
			if (_verticalAlign == value)
				return;
			
			_verticalAlign = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		//----------------------------------
		//  columnAlign
		//----------------------------------
		
		private var _columnAlign:String = ColumnAlign.LEFT;
		
		[Inspectable(category="General", enumeration="left,justifyUsingGap,justifyUsingWidth", defaultValue="left")]
		
		/**
		 *  Specifies how to justify the fully visible columns to the container width.
		 *  ActionScript values can be <code>ColumnAlign.LEFT</code>, <code>ColumnAlign.JUSTIFY_USING_GAP</code>
		 *  and <code>ColumnAlign.JUSTIFY_USING_WIDTH</code>.
		 *  MXML values can be <code>"left"</code>, <code>"justifyUsingGap"</code> and <code>"justifyUsingWidth"</code>.
		 *
		 *  <p>When set to <code>ColumnAlign.LEFT</code> it turns column justification off.
		 *  There may be partially visible columns or whitespace between the last column and
		 *  the right edge of the container.  This is the default value.</p>
		 *
		 *  <p>When set to <code>ColumnAlign.JUSTIFY_USING_GAP</code> the <code>horizontalGap</code>
		 *  actual value increases so that
		 *  the last fully visible column right edge aligns with the container's right edge.
		 *  In case there is only a single fully visible column, the <code>horizontalGap</code> actual value
		 *  increases so that it pushes any partially visible column beyond the right edge
		 *  of the container.  
		 *  Note that explicitly setting the <code>horizontalGap</code> property does not turn off
		 *  justification. It only determines the initial gap value. 
		 *  Justification may increases it.</p>
		 *
		 *  <p>When set to <code>ColumnAlign.JUSTIFY_USING_WIDTH</code> the <code>columnWidth</code>
		 *  actual value increases so that
		 *  the last fully visible column right edge aligns with the container's right edge.  
		 *  Note that explicitly setting the <code>columnWidth</code> property does not turn off justification.
		 *  It only determines the initial column width value. 
		 *  Justification may increases it.</p>
		 *
		 *  @see #horizontalGap
		 *  @see #columnWidth
		 *  @see #rowAlign
		 *  @default ColumnAlign.LEFT
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get columnAlign():String
		{
			return _columnAlign;
		}
		
		/**
		 *  @private
		 */
		public function set columnAlign(value:String):void
		{
			if (_columnAlign == value)
				return;
			
			_columnAlign = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		//----------------------------------
		//  rowAlign
		//----------------------------------
		
		private var _rowAlign:String = RowAlign.TOP;
		
		[Inspectable(category="General", enumeration="top,justifyUsingGap,justifyUsingHeight", defaultValue="top")]
		
		/**
		 *  Specifies how to justify the fully visible rows to the container height.
		 *  ActionScript values can be <code>RowAlign.TOP</code>, <code>RowAlign.JUSTIFY_USING_GAP</code>
		 *  and <code>RowAlign.JUSTIFY_USING_HEIGHT</code>.
		 *  MXML values can be <code>"top"</code>, <code>"justifyUsingGap"</code> and <code>"justifyUsingHeight"</code>.
		 *
		 *  <p>When set to <code>RowAlign.TOP</code> it turns column justification off. 
		 *  There might be partially visible rows or whitespace between the last row and
		 *  the bottom edge of the container.  This is the default value.</p>
		 *
		 *  <p>When set to <code>RowAlign.JUSTIFY_USING_GAP</code> the <code>verticalGap</code>
		 *  actual value increases so that
		 *  the last fully visible row bottom edge aligns with the container's bottom edge.
		 *  In case there is only a single fully visible row, the value of <code>verticalGap</code> 
		 *  increases so that it pushes any partially visible row beyond the bottom edge
		 *  of the container.  Note that explicitly setting the <code>verticalGap</code> does not turn off
		 *  justification, but just determines the initial gap value.
		 *  Justification can then increases it.</p>
		 *
		 *  <p>When set to <code>RowAlign.JUSTIFY_USING_HEIGHT</code> the <code>rowHeight</code>
		 *  actual value increases so that
		 *  the last fully visible row bottom edge aligns with the container's bottom edge.  Note that
		 *  explicitly setting the <code>rowHeight</code> does not turn off justification, but 
		 *  determines the initial row height value.
		 *  Justification can then increases it.</p>
		 *
		 *  @see #verticalGap
		 *  @see #rowHeight
		 *  @see #columnAlign
		 *  @default RowAlign.TOP
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get rowAlign():String
		{
			return _rowAlign;
		}
		
		/**
		 *  @private
		 */
		public function set rowAlign(value:String):void
		{
			if (_rowAlign == value)
				return;
			
			_rowAlign = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		//----------------------------------
		//  orientation
		//----------------------------------
		
		private var _orientation:String = TileOrientation.ROWS;
		
		[Inspectable(category="General", enumeration="rows,columns", defaultValue="rows")]
		
		/**
		 *  Specifies whether elements are arranged row by row or
		 *  column by column.
		 *  ActionScript values can be <code>TileOrientation.ROWS</code> and 
		 *  <code>TileOrientation.COLUMNS</code>.
		 *  MXML values can be <code>"rows"</code> and <code>"columns"</code>.
		 *
		 *  @default TileOrientation.ROWS
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get orientation():String
		{
			return _orientation;
		}
		
		/**
		 *  @private
		 */
		public function set orientation(value:String):void
		{
			if (_orientation == value)
				return;
			
			_orientation = value;
			_tileWidthCached = _tileHeightCached = NaN;
			invalidateTargetSizeAndDisplayList();
		}
		
		//----------------------------------
		//  useVirtualLayout
		//----------------------------------
		
		/**
		 *  @private
		 */
		override public function set useVirtualLayout(value:Boolean):void
		{
			if (useVirtualLayout == value)
				return;
			
			super.useVirtualLayout = value;
			
			// Reset the state that virtual depends on.  If the layout has already
			// run with useVirtualLayout=false, the visibleStartEndIndex variables
			// will have been set to 0, dataProvider.length.
			if (value)
			{
				visibleStartIndex = -1;  
				visibleEndIndex = -1;    
				visibleStartX = 0;
				visibleStartY = 0;
			}
		}     
		
		private var _orientationArray:Array = new Array();
		private var _orientationRowArray:Array = new Array();
		private var _orientationColumnArray:Array = new Array();
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function clearVirtualLayoutCache():void
		{
			_tileWidthCached = _tileHeightCached = NaN;
		}
		
		/**
		 *  @private
		 *  storage for old property values, in order to dispatch change events.
		 */
		private var oldColumnWidth:Number = NaN;
		private var oldRowHeight:Number = NaN;
		private var oldColumnCount:int = -1;
		private var oldRowCount:int = -1;
		private var oldHorizontalGap:Number = NaN;
		private var oldVerticalGap:Number = NaN;
		
		// Cache storage to avoid repeating work from measure() in updateDisplayList().
		// These are set the first time the value is calculated and are reset at the end
		// of updateDisplayList().
		private var _tileWidthCached:Number = NaN;
		private var _tileHeightCached:Number = NaN;
		private var _numElementsCached:int = -1;
		
		/**
		 *  @private
		 *  The following variables are used by updateDisplayList() and set by
		 *  calculateDisplayParameters().   If virtualLayout=true they're based 
		 *  on the current scrollRect.
		 */
		private var visibleStartIndex:int = -1;   // dataProvider/layout element index  
		private var visibleEndIndex:int = -1;     // ...
		private var visibleStartX:Number = 0;     // first tile/cell origin
		private var visibleStartY:Number = 0;     // ...
		
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Dispatches events if Actual values have changed since the last call.
		 *  Checks columnWidth, rowHeight, columnCount, rowCount, horizontalGap, verticalGap.
		 *  This method is called from within updateDisplayList()
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		private function dispatchEventsForActualValueChanges():void
		{
			if (hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
			{
				if (oldColumnWidth != _columnWidth)
					dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "columnWidth", oldColumnWidth, _columnWidth));
				if (oldRowHeight != _rowHeight)
					dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rowHeight", oldRowHeight, _rowHeight));
				if (oldColumnCount != _columnCount)
					dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "columnCount", oldColumnCount, _columnCount));
				if (oldRowCount != _rowCount)
					dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rowCount", oldRowCount, _rowCount));
				if (oldHorizontalGap != _horizontalGap)
					dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "horizontalGap", oldHorizontalGap, _horizontalGap));
				if (oldVerticalGap != _verticalGap)
					dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "verticalGap", oldVerticalGap, _verticalGap));
			}
			
			oldColumnWidth   = _columnWidth;
			oldRowHeight     = _rowHeight;
			oldColumnCount   = _columnCount;
			oldRowCount      = _rowCount;
			oldHorizontalGap = _horizontalGap;
			oldVerticalGap   = _verticalGap;
		}
		
		/**
		 *  This method is called from measure() and updateDisplayList() to calculate the
		 *  actual values for columnWidth, rowHeight, columnCount, rowCount, horizontalGap and verticalGap.
		 *
		 *  @param width - the width during measure() is the layout target explicitWidth or NaN
		 *  and during updateDisplayList() is the unscaledWidth.
		 *  @param height - the height during measure() is the layout target explicitHeight or NaN
		 *  and during updateDisplayList() is the unscaledHeight.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		private function updateActualValues(width:Number, height:Number):void
		{
			// First, figure the tile size
			calculateTileSize();
			
			// Second, figure out number of rows/columns
			var elementCount:int = calculateElementCount();
			calculateColumnAndRowCount(width, height, elementCount);
			
			// Third, adjust the gaps and column and row sizes based on justification settings
			_horizontalGap = explicitHorizontalGap;
			_verticalGap = explicitVerticalGap;
			
			// Justify
			switch (columnAlign)
			{
				case ColumnAlign.JUSTIFY_USING_GAP:
					_horizontalGap = justifyByGapSize(width, _columnWidth, _horizontalGap, _columnCount);
					break;
				case ColumnAlign.JUSTIFY_USING_WIDTH:
					_columnWidth = justifyByElementSize(width, _columnWidth, _horizontalGap, _columnCount);
					break;
			}
			
			switch (rowAlign)
			{
				case RowAlign.JUSTIFY_USING_GAP:
					_verticalGap = justifyByGapSize(height, _rowHeight, _verticalGap, _rowCount);
					break;
				case RowAlign.JUSTIFY_USING_HEIGHT:
					_rowHeight = justifyByElementSize(height, _rowHeight, _verticalGap, _rowCount);
					break;
			}
			
			// Last, if we have explicit overrides for both rowCount and columnCount, then
			// make sure that column/row count along the minor axis reflects the actual count.
			if (-1 != _requestedColumnCount && -1 != _requestedRowCount)
			{
				if (orientation == TileOrientation.ROWS)
					_rowCount = Math.max(1, Math.ceil(elementCount / Math.max(1, _requestedColumnCount)));
				else
					_columnCount = Math.max(1, Math.ceil(elementCount / Math.max(1, _requestedRowCount)));
			}
		}
		
		/**
		 *  @private
		 *  Returns true, if the dimensions (colCount1, rowCount1) are more square than (colCount2, rowCount2).
		 *  Squareness is the difference between width and height of a tile layout
		 *  with the specified number of columns and rows.
		 */
		private function closerToSquare(colCount1:int, rowCount1:int, colCount2:int, rowCount2:int):Boolean
		{
			var difference1:Number = Math.abs(colCount1 * (_columnWidth + _horizontalGap) - _horizontalGap - 
				rowCount1 * (_rowHeight   +   _verticalGap) + _verticalGap);
			var difference2:Number = Math.abs(colCount2 * (_columnWidth + _horizontalGap) - _horizontalGap - 
				rowCount2 * (_rowHeight   +   _verticalGap) + _verticalGap);
			
			return difference1 < difference2 || (difference1 == difference2 && rowCount1 <= rowCount2);
		}
		
		/**
		 *  @private
		 *  Calculates _columnCount and _rowCount based on width, height,
		 *  orientation, _requestedColumnCount, _requestedRowCount, _columnWidth, _rowHeight.
		 *  _columnWidth and _rowHeight must be valid before calling.
		 */
		private function calculateColumnAndRowCount(width:Number, height:Number, elementCount:int):void
		{
			_columnCount = _rowCount = -1;
			
			if (-1 != _requestedColumnCount || -1 != _requestedRowCount)
			{
				if (-1 != _requestedRowCount)
					_rowCount = Math.max(1, _requestedRowCount);
				
				if (-1 != _requestedColumnCount)
					_columnCount = Math.max(1, _requestedColumnCount);
			}
				// Figure out number of columns or rows based on the explicit size along one of the axes
			else if (!isNaN(width) && (orientation == TileOrientation.ROWS || isNaN(height)))
			{
				if (_columnWidth + explicitHorizontalGap > 0)
					_columnCount = Math.max(1, Math.floor((width + explicitHorizontalGap) / (_columnWidth + explicitHorizontalGap)));
				else
					_columnCount = 1;
			}
			else if (!isNaN(height) && (orientation == TileOrientation.COLUMNS || isNaN(width)))
			{
				if (_rowHeight + explicitVerticalGap > 0)
					_rowCount = Math.max(1, Math.floor((height + explicitVerticalGap) / (_rowHeight + explicitVerticalGap)));
				else
					_rowCount = 1;
			}
			else // Figure out the number of columns and rows so that pixels area occupied is as square as possible
			{
				// Calculate number of rows and columns so that
				// pixel area is as square as possible
				var hGap:Number = explicitHorizontalGap;
				var vGap:Number = explicitVerticalGap;
				
				// 1. columnCount * (columnWidth + hGap) - hGap == rowCount * (rowHeight + vGap) - vGap
				// 1. columnCount * (columnWidth + hGap) == rowCount * (rowHeight + vGap) + hGap - vGap
				// 1. columnCount == (rowCount * (rowHeight + vGap) + hGap - vGap) / (columnWidth + hGap)
				// 2. columnCount * rowCount == elementCount
				// substitute 1. in 2.
				// rowCount * rowCount + (hGap - vGap) * rowCount - elementCount * (columnWidth + hGap ) == 0
				
				var a:Number = Math.max(0, (rowHeight + vGap));
				var b:Number = (hGap - vGap);
				var c:Number = -elementCount * (_columnWidth + hGap);
				var d:Number = b * b - 4 * a * c; // Always guaranteed to be greater than zero, since c <= 0
				d = Math.sqrt(d);
				
				// We are guaranteed that we have only one positive root, since d >= b:
				var rowCount:Number = (a != 0) ? (b + d) / (2 * a) : elementCount;
				
				// To get integer count for the columns/rows we round up and down so
				// we get four possible solutions. Then we pick the best one.
				var row1:int = Math.max(1, Math.floor(rowCount));
				var col1:int = Math.max(1, Math.ceil(elementCount / row1));
				row1 = Math.max(1, Math.ceil(elementCount / col1));
				
				var row2:int = Math.max(1, Math.ceil(rowCount));
				var col2:int = Math.max(1, Math.ceil(elementCount / row2));
				row2 = Math.max(1, Math.ceil(elementCount / col2));
				
				var col3:int = Math.max(1, Math.floor(elementCount / rowCount));
				var row3:int = Math.max(1, Math.ceil(elementCount / col3));
				col3 = Math.max(1, Math.ceil(elementCount / row3));
				
				var col4:int = Math.max(1, Math.ceil(elementCount / rowCount));
				var row4:int = Math.max(1, Math.ceil(elementCount / col4));
				col4 = Math.max(1, Math.ceil(elementCount / row4));
				
				if (closerToSquare(col3, row3, col1, row1))
				{
					col1 = col3;
					row1 = row3;
				}
				
				if (closerToSquare(col4, row4, col2, row2))
				{
					col2 = col4;
					row2 = row4;
				}
				
				if (closerToSquare(col1, row1, col2, row2))
				{
					_columnCount = col1;
					_rowCount = row1;
				}
				else
				{
					_columnCount = col2;
					_rowCount = row2;
				}
			}
			
			// In case we determined only columns or rows (from explicit overrides or explicit width/height)
			// calculate the other from the number of elements
			if (-1 == _rowCount)
				_rowCount = Math.max(1, Math.ceil(elementCount / _columnCount));
			if (-1 == _columnCount)
				_columnCount = Math.max(1, Math.ceil(elementCount / _rowCount));
		}
		
		/**
		 *  @private
		 *  Increases the gap so that elements are justified to exactly fit totalSize
		 *  leaving no partially visible elements in view.
		 *  @return Returs the new gap size.
		 */
		private function justifyByGapSize(totalSize:Number, elementSize:Number,
										  gap:Number, elementCount:int):Number
		{
			// If element + gap collapses to zero, then don't adjust the gap.
			if (elementSize + gap <= 0)
				return gap;
			
			// Find the number of fully visible elements
			var visibleCount:int =
				Math.min(elementCount, Math.floor((totalSize + gap) / (elementSize + gap)));
			
			// If there isn't even a singel fully visible element, don't adjust the gap
			if (visibleCount < 1)
				return gap;
			
			// Special case: if there's a singe fully visible element and a partially
			// visible element, then make the gap big enough to push out the partially
			// visible element out of view.
			if (visibleCount == 1)
				return elementCount > 1 ? Math.max(gap, totalSize - elementSize) : gap;
			
			// Now calculate the gap such that the fully visible elements and gaps
			// add up exactly to totalSize:
			// <==> totalSize == visibleCount * elementSize + (visibleCount - 1) * gap
			// <==> totalSize - visibleCount * elementSize == (visibleCount - 1) * gap
			// <==> (totalSize - visibleCount * elementSize) / (visibleCount - 1) == gap
			return (totalSize - visibleCount * elementSize) / (visibleCount - 1);
		}
		
		/**
		 *  @private
		 *  Increases the element size so that elements are justified to exactly fit
		 *  totalSize leaving no partially visible elements in view.
		 *  @return Returns the the new element size.
		 */
		private function justifyByElementSize(totalSize:Number, elementSize:Number,
											  gap:Number, elementCount:int):Number
		{
			var elementAndGapSize:Number = elementSize + gap;
			var visibleCount:int = 0;
			// Find the number of fully visible elements
			if (elementAndGapSize == 0)
				visibleCount = elementCount;
			else
				visibleCount = Math.min(elementCount, Math.floor((totalSize + gap) / elementAndGapSize));
			
			// If there isn't event a single fully visible element, don't adjust
			if (visibleCount < 1)
				return elementSize;
			
			// Now calculate the elementSize such that the fully visible elements and gaps
			// add up exactly to totalSize:
			// <==> totalSize == visibleCount * elementSize + (visibleCount - 1) * gap
			// <==> totalSize - (visibleCount - 1) * gap == visibleCount * elementSize
			// <==> (totalSize - (visibleCount - 1) * gap) / visibleCount == elementSize
			return (totalSize - (visibleCount - 1) * gap) / visibleCount;
		}
		
		/**
		 *  @private
		 *  Update _tileWidth,Height to be the maximum of their current
		 *  value and the element's preferred bounds. 
		 */
		private function updateVirtualTileSize(elt:ILayoutElement):void
		{
			if (!elt || !elt.includeInLayout)
				return;
			var w:Number = elt.getPreferredBoundsWidth();
			var h:Number = elt.getPreferredBoundsHeight();
			_tileWidthCached = isNaN(_tileWidthCached) ? w : Math.max(w, _tileWidthCached);
			_tileHeightCached = isNaN(_tileHeightCached) ? h : Math.max(h, _tileHeightCached);
		}
		
		/**
		 *  @private
		 */
		private function calculateVirtualTileSize():void
		{
			// If both dimensions are explicitly set, we're done
			_columnWidth = explicitColumnWidth;
			_rowHeight = explicitRowHeight;
			if (!isNaN(_columnWidth) && !isNaN(_rowHeight))
			{
				_tileWidthCached = _columnWidth;
				_tileHeightCached = _rowHeight;
				return;
			}
			
			// update _tileWidth,HeightCached based on the typicalElement     
			updateVirtualTileSize(typicalLayoutElement);
			
			// update _tileWidth,HeightCached based on visible elements    
			if ((visibleStartIndex != -1) && (visibleEndIndex != -1))
			{
				for (var index:int = visibleStartIndex; index <= visibleEndIndex; index++)
					updateVirtualTileSize(target.getVirtualElementAt(index));
			}
			
			// Make sure that we always have non-NaN values in the cache, even
			// when there are no elements.
			if (isNaN(_tileWidthCached))
				_tileWidthCached = 0;
			if (isNaN(_tileHeightCached))
				_tileHeightCached = 0;
			
			if (isNaN(_columnWidth))
				_columnWidth = _tileWidthCached;
			if (isNaN(_rowHeight))
				_rowHeight = _tileHeightCached;        
		}
		
		/**
		 *  @private
		 *  Calculates _columnWidth and _rowHeight from maximum of
		 *  elements preferred size and any explicit overrides.
		 */
		private function calculateRealTileSize():void
		{
			_columnWidth = _tileWidthCached;
			_rowHeight = _tileHeightCached;
			if (!isNaN(_columnWidth) && !isNaN(_rowHeight))
				return;
			
			// Are both dimensions explicitly set?
			_columnWidth = _tileWidthCached = explicitColumnWidth;
			_rowHeight = _tileHeightCached = explicitRowHeight;
			if (!isNaN(_columnWidth) && !isNaN(_rowHeight))
				return;
			
			// Find the maxmimums of element's preferred sizes
			var columnWidth:Number = 0;
			var rowHeight:Number = 0;
			
			var layoutTarget:GroupBase = target;
			var count:int = layoutTarget.numElements;
			// Remember the number of includeInLayout elements
			_numElementsCached = count;
			for (var i:int = 0; i < count; i++)
			{
				var el:ILayoutElement = layoutTarget.getElementAt(i);
				if (!el || !el.includeInLayout)
				{
					_numElementsCached--;
					continue;
				}
				
				if (isNaN(_columnWidth))
					columnWidth = Math.max(columnWidth, el.getPreferredBoundsWidth());
				if (isNaN(_rowHeight))
					rowHeight = Math.max(rowHeight, el.getPreferredBoundsHeight());
			}
			
			if (isNaN(_columnWidth))
				_columnWidth = _tileWidthCached = columnWidth;
			if (isNaN(_rowHeight))
				_rowHeight = _tileHeightCached = rowHeight;
		}
		
		private function calculateTileSize():void    
		{
			if (useVirtualLayout)
				calculateVirtualTileSize();
			else 
				calculateRealTileSize();
		}    
		
		/**
		 *  @private
		 *  For normal layout return the number of non-null includeInLayout=true
		 *  layout elements, for virtual layout just return the number of layout
		 *  elements.
		 */
		private function calculateElementCount():int
		{
			if (-1 != _numElementsCached)
				return _numElementsCached;
			
			var layoutTarget:GroupBase = target;
			var count:int = layoutTarget.numElements;
			_numElementsCached = count;
			
			if (useVirtualLayout)
				return _numElementsCached;
			
			for (var i:int = 0; i < count; i++)
			{
				var el:ILayoutElement = layoutTarget.getElementAt(i);
				if (!el || !el.includeInLayout)
					_numElementsCached--;
			}
			
			return _numElementsCached;
		}
		
		/**
		 *  @private
		 *  This method computes values for visibleStartX,Y, visibleStartIndex, and 
		 *  visibleEndIndex based on the TileLayout geometry values, like _columnWidth
		 *  and _rowHeight, computed by calculateActualValues().
		 * 
		 *  If useVirtualLayout=false, then visibleStartX,Y=0 and visibleStartIndex=0
		 *  and visibleEndIndex=layoutTarget.numElements-1.
		 * 
		 *  If useVirtualLayout=true and orientation=ROWS then visibleStartIndex is the 
		 *  layout element index of the item at first visible row relative to the scrollRect, 
		 *  column 0.  Note that we're using column=0 instead of the first visible column
		 *  to simplify the iteration logic in updateDisplayList().  This is optimal 
		 *  for the common case where the entire row is visible.   Optimally handling 
		 *  the case where orientation=ROWS and each row is only partially visible is 
		 *  doable but adds some complexity to the main loop.
		 * 
		 *  The logic for useVirtualLayout=true and orientation=COLS is similar.
		 */
		private function calculateDisplayParameters(unscaledWidth:int, unscaledHeight:int):void
		{
			updateActualValues(unscaledWidth, unscaledHeight);
			
			var layoutTarget:GroupBase = target;
			var eltCount:int = layoutTarget.numElements;
			visibleStartX = 0;   // initial values for xPos,yPos in updateDisplayList
			visibleStartY = 0;
			visibleStartIndex = 0;
			visibleEndIndex = eltCount - 1;
			
			if (useVirtualLayout)
			{
				var hsp:Number = layoutTarget.horizontalScrollPosition;
				var vsp:Number = layoutTarget.verticalScrollPosition;
				var cwg:Number = _columnWidth + _horizontalGap;
				var rwg:Number = _rowHeight + _verticalGap;
				
				var visibleCol0:int = Math.max(0, Math.floor(hsp / cwg));
				var visibleRow0:int = Math.max(0, Math.floor(vsp / rwg));
				var visibleCol1:int = Math.min(_columnCount - 1, Math.floor((hsp + unscaledWidth) / cwg));
				var visibleRow1:int = Math.min(_rowCount - 1, Math.floor((vsp + unscaledHeight) / rwg));
				
				if (orientation == TileOrientation.ROWS)
				{
					visibleStartIndex = (visibleRow0 * _columnCount);
					visibleEndIndex = Math.min(eltCount - 1, (visibleRow1 * _columnCount) + visibleCol1); 
					visibleStartY = visibleRow0 * rwg;
				}
				else
				{
					visibleStartIndex = (visibleCol0 * _rowCount);
					visibleEndIndex = Math.min(eltCount - 1, (visibleCol1 * _rowCount) + visibleRow1);
					visibleStartX = visibleCol0 * cwg;                
				}
			}
		}
		
		/**
		 *  @private
		 *  This method is called by updateDisplayList() after initial values for 
		 *  visibleStartIndex, visibleEndIndex have been calculated.  We 
		 *  re-calculateDisplayParameters() to account for the possibility that
		 *  larger cells may have been exposed.  Since tileWdth,Height can only
		 *  increase, the new visibleStart,EndIndex values will be greater than or
		 *  equal to the old ones. 
		 */
		private function updateVirtualLayout(unscaledWidth:int, unscaledHeight:int):void
		{
			var oldVisibleStartIndex:int = visibleStartIndex;
			var oldVisibleEndIndex:int = visibleEndIndex;
			calculateDisplayParameters(unscaledWidth, unscaledHeight);  // compute new visibleStart,EndIndex values
			
			// We're responsible for laying out *all* of the elements requested
			// with getVirtualElementAt(), even if they don't fall within the final
			// visible range.  Hide any extra ones.  On the next layout pass, they'll
			// be added to DataGroup::freeRenderers
			
			var layoutTarget:GroupBase = target;
			for (var i:int = oldVisibleStartIndex; i <= oldVisibleEndIndex; i++)
			{
				if ((i >= visibleStartIndex) && (i <= visibleEndIndex)) // skip past the visible range
				{
					i = visibleEndIndex;
					continue;
				} 
				var el:ILayoutElement = layoutTarget.getVirtualElementAt(i);
				if (!el)
					continue;
				el.setLayoutBoundsSize(0, 0);
				if (el is IVisualElement)
					IVisualElement(el).visible = false; 
			}
		}    
		
		/**
		 *  Sets the size and the position of the specified layout element and cell bounds.
		 *  @param element - the element to resize and position.
		 *  @param cellX - the x coordinate of the cell.
		 *  @param cellY - the y coordinate of the cell.
		 *  @param cellWidth - the width of the cell.
		 *  @param cellHeight - the height of the cell.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		private function sizeAndPositionElement(element:ILayoutElement,
												cellX:int,
												cellY:int,
												cellWidth:int,
												cellHeight:int):void
		{
			var childWidth:Number = NaN;
			var childHeight:Number = NaN;
			
			// Determine size of the element
			if (horizontalAlign == "justify")
				childWidth = cellWidth;
			else if (!isNaN(element.percentWidth))
				childWidth = Math.round(cellWidth * element.percentWidth * 0.01);
			else
				childWidth = element.getPreferredBoundsWidth();
			
			if (verticalAlign == "justify")
				childHeight = cellHeight;
			else if (!isNaN(element.percentHeight))
				childHeight = Math.round(cellHeight * element.percentHeight * 0.01);
			else
				childHeight = element.getPreferredBoundsHeight();
			
			// Enforce min and max limits
			var maxChildWidth:Number = Math.min(element.getMaxBoundsWidth(), cellWidth);
			var maxChildHeight:Number = Math.min(element.getMaxBoundsHeight(), cellHeight);
			// Make sure we enforce element's minimum last, since it has the highest priority
			childWidth = Math.max(element.getMinBoundsWidth(), Math.min(maxChildWidth, childWidth));
			childHeight = Math.max(element.getMinBoundsHeight(), Math.min(maxChildHeight, childHeight));
			
			// Size the element
			element.setLayoutBoundsSize(childWidth, childHeight);
			
			var x:Number = cellX;
			switch (horizontalAlign)
			{
				case "right":
					x += cellWidth - element.getLayoutBoundsWidth();
					break;
				case "center":
					// Make sure division result is integer - Math.floor() the result.
					x = cellX + Math.floor((cellWidth - element.getLayoutBoundsWidth()) / 2);
					break;
			}
			
			var y:Number = cellY;
			switch (verticalAlign)
			{
				case "bottom":
					y += cellHeight - element.getLayoutBoundsHeight();
					break;
				case "middle":
					// Make sure division result is integer - Math.floor() the result.
					y += Math.floor((cellHeight - element.getLayoutBoundsHeight()) / 2);
					break;
			}
			
			// Position the element
			element.setLayoutBoundsPosition(x, y);
		}
		
		/**
		 *  @private
		 *  @return Returns the x coordinate of the left edge for the specified column.
		 */
		final private function leftEdge(columnIndex:int):Number
		{
			return Math.max(0, columnIndex * (_columnWidth + _horizontalGap));
		}
		
		/**
		 *  @private
		 *  @return Returns the x coordinate of the right edge for the specified column.
		 */
		final private function rightEdge(columnIndex:int):Number
		{
			return Math.min(target.contentWidth, columnIndex * (_columnWidth + _horizontalGap) + _columnWidth);
		}
		
		/**
		 *  @private
		 *  @return Returns the y coordinate of the top edge for the specified row.
		 */
		final private function topEdge(rowIndex:int):Number
		{
			return Math.max(0, rowIndex * (_rowHeight + _verticalGap));
		}
		
		/**
		 *  @private
		 *  @return Returns the y coordinate of the bottom edge for the specified row.
		 */
		final private function bottomEdge(rowIndex:int):Number
		{
			return Math.min(target.contentHeight, rowIndex * (_rowHeight + _verticalGap) + _rowHeight);
		}
		
		/**
		 *  @private 
		 *  Convenience function for subclasses that invalidates the
		 *  target's size and displayList so that both layout's <code>measure()</code>
		 *  and <code>updateDisplayList</code> methods get called.
		 * 
		 *  <p>Typically a layout invalidates the target's size and display list so that
		 *  it gets a chance to recalculate the target's default size and also size and
		 *  position the target's elements. For example changing the <code>gap</code>
		 *  property on a <code>VerticalLayout</code> will internally call this method
		 *  to ensure that the elements are re-arranged with the new setting and the
		 *  target's default size is recomputed.</p> 
		 */
		private function invalidateTargetSizeAndDisplayList():void
		{
			var g:GroupBase = target;
			if (!g)
				return;
			
			g.invalidateSize();
			g.invalidateDisplayList();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods from LayoutBase
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function scrollPositionChanged():void
		{
			super.scrollPositionChanged();
			
			var layoutTarget:GroupBase = target;
			if (!layoutTarget)
				return;
			
			if (useVirtualLayout)
				layoutTarget.invalidateDisplayList();
		}
		
		
		/**
		 *  @private 
		 */  
		override public function getNavigationDestinationIndex(currentIndex:int, navigationUnit:uint, arrowKeysWrapFocus:Boolean):int
		{
			if (!target || target.numElements < 1)
				return -1; 
			
			var maxIndex:int = target.numElements - 1;
			
			// Special case when nothing was previously selected
			if (currentIndex == -1)
			{
				if (navigationUnit == NavigationUnit.UP || navigationUnit == NavigationUnit.LEFT)
					return arrowKeysWrapFocus ? maxIndex : -1;
				
				if (navigationUnit == NavigationUnit.DOWN || navigationUnit == NavigationUnit.RIGHT)
					return 0;    
			}    
			
			// Make sure currentIndex is within range
			var inRows:Boolean = orientation == TileOrientation.ROWS;
			currentIndex = Math.max(0, Math.min(maxIndex, currentIndex));
			
			// Find the current column and row
			var currentRow:int;
			var currentColumn:int;
			if (inRows)
			{
				// Is the TileLayout initialized with valid values?
				if (columnCount == 0 || rowHeight + verticalGap == 0)
					return currentIndex;
				
				currentRow = currentIndex / columnCount;
				currentColumn = currentIndex - currentRow * columnCount;
			}
			else
			{
				// Is the TileLayout initialized with valid values?
				if (rowCount == 0 || columnWidth + horizontalGap == 0)
					return currentIndex;
				
				currentColumn = currentIndex / rowCount;
				currentRow = currentIndex - currentColumn * rowCount;
			}
			
			var newRow:int = currentRow;
			var newColumn:int = currentColumn;
			
			// Handle user input, almost all range checks are
			// performed after the calculations, at the end of the method.
			switch (navigationUnit)
			{
				case NavigationUnit.LEFT: 
				{
					// If we are at the first column, can
					// we go to the previous element (last column, previous row)?
					if (newColumn == 0 && inRows && newRow > 0)
					{
						newRow--;
						newColumn = columnCount - 1;
					}
					else if (arrowKeysWrapFocus && newColumn == 0 && inRows && newRow == 0)
					{
						newRow = rowCount - 1;
						newColumn = columnCount - 1;
					}
					else
						newColumn--;
					break;
				}
					
				case NavigationUnit.RIGHT:
				{
					// If we are at the last column, can
					// we go to the next element (first column, next row)?
					if (newColumn == columnCount - 1 && inRows && newRow < rowCount - 1)
					{
						newColumn = 0;
						newRow++;
					}
					else if (arrowKeysWrapFocus && newColumn == columnCount - 1 && inRows && newRow == rowCount - 1)
					{
						newColumn = 0;
						newRow = 0;
					}
					else
						newColumn++;
					break;
				} 
					
				case NavigationUnit.UP:
				{
					// If we are at the first row, can we
					// go to the previous element (previous column, last row)?
					if (newRow == 0 && !inRows && newColumn > 0)
					{
						newColumn--;
						newRow = rowCount - 1;
					}
					else if (arrowKeysWrapFocus && newRow == 0 && !inRows && newColumn == 0)
					{
						newColumn = columnCount - 1;
						newRow = rowCount - 1;
					}
					else
						newRow--;
					break; 
				}
					
				case NavigationUnit.DOWN:
				{
					// If we are at the last row, can we
					// go to the next element (next column, first row)?
					if (newRow == rowCount - 1 && !inRows && newColumn < columnCount - 1)
					{
						newColumn++;
						newRow = 0;
					}
					else if (arrowKeysWrapFocus && newRow == rowCount - 1 && !inRows && newColumn == columnCount - 1)
					{
						newColumn = 0;
						newRow = 0;
					}
					else
						newRow++;
					break; 
				}
					
				case NavigationUnit.PAGE_UP:
				case NavigationUnit.PAGE_DOWN:
				{
					// Ensure we have a valid scrollRect as we use it for calculations below
					var scrollRect:Rectangle = getScrollRect();
					if (!scrollRect)
						scrollRect = new Rectangle(0, 0, target.contentWidth, target.contentHeight);
					
					if (inRows)
					{
						var firstVisibleRow:int = Math.ceil(scrollRect.top / (rowHeight + verticalGap));
						var lastVisibleRow:int = Math.floor(scrollRect.bottom / (rowHeight + verticalGap));
						
						if (navigationUnit == NavigationUnit.PAGE_UP)
						{
							// Is the current row visible, somewhere in the middle of the scrollRect?
							if (firstVisibleRow < currentRow && currentRow <= lastVisibleRow)
								newRow = firstVisibleRow;
							else                             
								newRow = 2 * firstVisibleRow - lastVisibleRow;
						} 
						else
						{
							// Is the current row visible, somewhere in the middle of the scrollRect?
							if (firstVisibleRow <= currentRow && currentRow < lastVisibleRow)
								newRow = lastVisibleRow;
							else                             
								newRow = 2 * lastVisibleRow - firstVisibleRow;
						}
					}
					else
					{
						var firstVisibleColumn:int = Math.ceil(scrollRect.left / (columnWidth + horizontalGap));
						var lastVisibleColumn:int = Math.floor(scrollRect.right / (columnWidth + horizontalGap));
						
						if (navigationUnit == NavigationUnit.PAGE_UP)
						{
							// Is the current column visible, somewhere in the middle of the scrollRect?
							if (firstVisibleColumn < currentColumn && currentColumn <= lastVisibleColumn)
								newColumn = firstVisibleColumn;
							else    
								newColumn = 2 * firstVisibleColumn - lastVisibleColumn; 
						}
						else
						{
							// Is the current column visible, somewhere in the middle of the scrollRect?
							if (firstVisibleColumn <= currentColumn && currentColumn < lastVisibleColumn)
								newColumn = lastVisibleColumn;
							else    
								newColumn = 2 * lastVisibleColumn - firstVisibleColumn;
						}
					}
					break; 
				}
				default: return super.getNavigationDestinationIndex(currentIndex, navigationUnit, arrowKeysWrapFocus);
			}
			
			// Make sure rows and columns are within range
			newRow = Math.max(0, Math.min(rowCount - 1, newRow));
			newColumn = Math.max(0, Math.min(columnCount - 1, newColumn));
			
			// Calculate the new index based on orientation        
			if (inRows)  
			{
				// Make sure we don't return an index for an empty space in the last row.
				// newRow is guaranteed to be greater than zero:
				
				// Step 1: We can end up at the empty space in the last row if we moved right from
				// the last item.
				if (currentIndex == maxIndex && newColumn > currentColumn)
					newColumn = currentColumn;
				
				// Step 2: We can end up at the empty space in the last row if we moved down from
				// the previous row.    
				if (newRow == rowCount - 1 && newColumn > maxIndex - columnCount * (rowCount - 1))
					newRow--;
				
				return newRow * columnCount + newColumn;
			}
			else
			{
				// Make sure we don't return an index for an empty space in the last column.
				// newColumn is guaranteed to be greater than zero:
				
				// Step 1: We can end up at the empty space in the last column if we moved down from
				// the last item.
				if (currentIndex == maxIndex && newRow > currentRow)
					newRow = currentRow;
				
				// Step 2: We can end up at the empty space in the last column if we moved right from
				// the previous column.    
				if (newColumn == columnCount - 1 && newRow > maxIndex - rowCount * (columnCount - 1))
					newColumn--;
				
				return newColumn * rowCount + newRow;
			}
		}
		
		/**
		 *  @private
		 */
		override public function measure():void
		{
			var layoutTarget:GroupBase = target;
			if (!layoutTarget)
				return;
			
			//updateActualValues(layoutTarget.explicitWidth, layoutTarget.explicitHeight);
			
			var elementCount:int = calculateElementCount();
			_rowCount = Math.max(1, Math.ceil(elementCount / _columnCount));
			_columnCount = Math.max(1, Math.ceil(elementCount / _rowCount));
			
			var x:int = 0;
			var w:int = 0;	
			var h:int = 0;	
			var tempSize:int = 0;
			
			if (orientation == TileOrientation.ROWS)
			{
				// This does not work if the requestedRowCount is 0 or nothing | also will not fill width if set to nothing
				if (_orientationColumnArray.length > 0)
				{
					for (x = 0; x < _columnCount; x++)
					{
						tempSize = w;
						for (var y:int = 0; y < _rowCount; y++)
						{
							if (y >= _orientationRowArray.length) break;
							w += _orientationRowArray[y].xMajorDelta;
							y += _columnCount;
						}
						w = Math.max(tempSize, w);
					}
					w -= _horizontalGap;
				}
				
				if (_orientationRowArray.length > 0)
				{
					for (x = 0; x <  _rowCount; x++)
					{
						if (x >= _orientationRowArray.length) break;
						h += _orientationRowArray[x].yMinorDelta;
					}
					h -= _verticalGap;
				}				
			}
			else
			{
				if (_orientationColumnArray.length > 0)
				{
					for (x = 0; x < _columnCount; x++)
					{
						if (x >= _orientationColumnArray.length) break;
						
						if (orientation == TileOrientation.ROWS)
							w += _orientationColumnArray[x].xMajorDelta;
						else
							w += _orientationColumnArray[x].xMinorDelta;
					}
					w -= _horizontalGap;
				}
				
				if (_orientationRowArray.length > 0)
				{
					for (x = 0; x <  _rowCount; x++)
					{
						if (x >= _orientationRowArray.length) break;
						
						if (orientation == TileOrientation.ROWS)
							h += _orientationRowArray[x].yMinorDelta;
						else
							h += _orientationRowArray[x].yMajorDelta;	
					}
					h -= _verticalGap;
				}
			}
			
			layoutTarget.measuredWidth = layoutTarget.measuredMinWidth = w;
			layoutTarget.measuredHeight = layoutTarget.measuredMinHeight = h;
		}
		
		protected function findDeltas(counterLimit:int, counter:int):Array
		{
			var orientationArray:Array = new Array();
			var layoutTarget:GroupBase = target;
			for (var y:int = 0; y < counter; y++)
			{
				var largestColumn:int = 0;
				var largestRow:int = 0;
				
				for (var x:int = y*counterLimit; x < (y*counterLimit)+counterLimit; x++)
				{
					if (x > layoutTarget.numElements-1) 
						break;
					
					var el:ILayoutElement = null; 
					if (useVirtualLayout)
					{
						el = layoutTarget.getVirtualElementAt(x);
						if (el is IVisualElement)  // see updateVirtualLayout
							IVisualElement(el).visible = true; 
					}
					else el = layoutTarget.getElementAt(x);
					
					if (!el || !el.includeInLayout)
						continue;
					
					largestRow = Math.max(UIComponent(el).measuredHeight, largestRow);
					largestColumn = Math.max(UIComponent(el).measuredWidth, largestColumn);
				}	
				
				if (orientation == TileOrientation.ROWS)
				{
					orientationArray[y] =
						{
							
							'xMajorDelta' : largestColumn + _horizontalGap,
								'xMinorDelta' : 0,
								'yMajorDelta' : 0,
								'yMinorDelta' : largestRow + _verticalGap
						}
				}
				else
				{
					orientationArray[y] =
						{
							'xMajorDelta' : 0,
							'xMinorDelta' : largestColumn + _horizontalGap,
								'yMajorDelta' : largestRow + _verticalGap,
								'yMinorDelta' : 0
						}
				}
			}
			
			return orientationArray;
		}
		
		/**
		 *  @private
		 */
		override public function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var layoutTarget:GroupBase = target;
			if (!layoutTarget)
				return;
			
			calculateDisplayParameters(unscaledWidth, unscaledHeight);
			if (useVirtualLayout)
				updateVirtualLayout(unscaledWidth, unscaledHeight);  // re-calculateDisplayParameters()
			
			// Upper right hand corner of first (visibleStartIndex) tile/cell
			var xPos:Number = visibleStartX;  // 0 if useVirtualLayout=false
			var yPos:Number = visibleStartY;  // ...
			
			// Use MajorDelta when moving along the major axis
			var xMajorDelta:Number;
			var yMajorDelta:Number;
			
			// Use MinorDelta when moving along the minor axis
			var xMinorDelta:Number;
			var yMinorDelta:Number;
			
			// Use counter and counterLimit to track when to move along the minor axis
			var counter:int = 0;
			var variableCounter:int = 0;
			var counterLimit:int;
			
			_orientationRowArray = findDeltas(_columnCount, _requestedRowCount > 0 ? _requestedRowCount : Math.ceil(visibleEndIndex/_columnCount)+1 );
			_orientationColumnArray = findDeltas(_rowCount, _requestedColumnCount > 0 ? _requestedColumnCount : Math.ceil(visibleEndIndex/_rowCount)+1 );
			
			var elementWidth:int = 0;
			var elementHeight:int = 0;
			
			// Setup counterLimit and size based on orientation
			if (orientation == TileOrientation.ROWS)
			{
				counterLimit = _columnCount;
				elementWidth = _orientationRowArray[0].xMajorDelta - _horizontalGap;
				elementHeight = _orientationRowArray[0].yMinorDelta - _verticalGap;
			}
			else
			{
				counterLimit = _rowCount;
				elementWidth = _orientationColumnArray[0].xMinorDelta - Math.round(xPos) - _horizontalGap;
				elementHeight = _orientationColumnArray[0].yMajorDelta - Math.round(yPos) - _verticalGap;
			}
			
			for(var index:int = visibleStartIndex; index <= visibleEndIndex; index++)
			{
				var el:ILayoutElement = null; 
				if (useVirtualLayout)
				{
					el = layoutTarget.getVirtualElementAt(index);
					if (el is IVisualElement)  // see updateVirtualLayout
						IVisualElement(el).visible = true; 
				}
				else
					el = layoutTarget.getElementAt(index);
				
				if (!el || !el.includeInLayout)
					continue;
				
				// To calculate the cell extents as integers, first calculate
				// the extents and then use Math.round()
				var cellX:int = Math.round(xPos);
				var cellY:int = Math.round(yPos);
				var cellWidth:int = Math.round(xPos + elementWidth) - cellX;
				var cellHeight:int = Math.round(yPos + elementHeight) - cellY;
				
				sizeAndPositionElement(el, cellX, cellY, cellWidth, cellHeight);
				
				// Move along the major axis
				if (orientation == TileOrientation.ROWS)
				{
					xPos += _orientationRowArray[variableCounter].xMajorDelta;
					yPos += _orientationRowArray[variableCounter].yMajorDelta;
				}
				else
				{
					xPos += _orientationColumnArray[variableCounter].xMajorDelta;
					yPos += _orientationColumnArray[variableCounter].yMajorDelta;
				}
				
				// Move along the minor axis
				if (++counter >= counterLimit)
				{
					counter = 0;
					if (orientation == TileOrientation.ROWS && ((variableCounter + 1) < _orientationRowArray.length))
					{
						xPos = 0;
						yPos += _orientationRowArray[variableCounter].yMinorDelta;
						elementWidth = _orientationRowArray[variableCounter+1].xMajorDelta - _horizontalGap;
						elementHeight = _orientationRowArray[variableCounter+1].yMinorDelta - _verticalGap;
					}
					else if (orientation == TileOrientation.COLUMNS && ((variableCounter + 1) < _orientationColumnArray.length))
					{
						xPos += _orientationColumnArray[variableCounter].xMinorDelta;
						yPos = 0;
						elementWidth = _orientationColumnArray[variableCounter+1].xMinorDelta - _horizontalGap;
						elementHeight = _orientationColumnArray[variableCounter+1].yMajorDelta - _verticalGap;
					}
					
					variableCounter++;
				}
			}
			
			// Make sure that if the content spans partially over a pixel to the right/bottom,
			// the content size includes the whole pixel.
			layoutTarget.setContentSize(Math.ceil(_columnCount * (_columnWidth + _horizontalGap) - _horizontalGap),
				Math.ceil(_rowCount * (_rowHeight + _verticalGap) - _verticalGap));
			
			// Reset the cache
			if (!useVirtualLayout)
				_tileWidthCached = _tileHeightCached = NaN;
			_numElementsCached = -1;
			
			// No getVirtualElementAt() during measure, see calculateVirtualTileSize()
			if (useVirtualLayout)
				visibleStartIndex = visibleEndIndex = -1;        
			
			// If actual values have chnaged, notify listeners
			dispatchEventsForActualValueChanges();
			layoutTarget.invalidateSize();
		}
		
		/**
		 *  @private
		 */
		override public function getElementBounds(index:int):Rectangle
		{
			if (!useVirtualLayout)
				return super.getElementBounds(index);
			
			var g:GroupBase = GroupBase(target);
			if (!g || (index < 0) || (index >= g.numElements)) 
				return null;
			
			var col:int;
			var row:int;
			if (orientation == TileOrientation.ROWS)
			{
				col = index % _columnCount;
				row = index / _columnCount;
			}
			else
			{
				col = index / _rowCount;
				row = index % _rowCount
			}
			return new Rectangle(leftEdge(col), topEdge(row), _columnWidth, _rowHeight);
		}
		
		/**
		 *  @private
		 */
		override protected function getElementBoundsLeftOfScrollRect(scrollRect:Rectangle):Rectangle
		{
			var bounds:Rectangle = new Rectangle();
			// Find the column that spans or is to the left of the scrollRect left edge.
			var column:int = Math.floor((scrollRect.left - 1) / (_columnWidth + _horizontalGap));
			bounds.left = leftEdge(column);
			bounds.right = rightEdge(column);
			return bounds;
		}
		
		/**
		 *  @private
		 */
		override protected function getElementBoundsRightOfScrollRect(scrollRect:Rectangle):Rectangle
		{
			var bounds:Rectangle = new Rectangle();
			// Find the column that spans or is to the right of the scrollRect right edge.
			var column:int = Math.floor((scrollRect.right + 1 + _horizontalGap) / (_columnWidth + _horizontalGap));
			bounds.left = leftEdge(column);
			bounds.right = rightEdge(column);
			return bounds;
		}
		
		/**
		 *  @private
		 */
		override protected function getElementBoundsAboveScrollRect(scrollRect:Rectangle):Rectangle
		{
			var bounds:Rectangle = new Rectangle();
			// Find the row that spans or is above the scrollRect top edge
			var row:int = Math.floor((scrollRect.top - 1) / (_rowHeight + _verticalGap));
			bounds.top = topEdge(row);
			bounds.bottom = bottomEdge(row);
			return bounds;
		}
		
		/**
		 *  @private
		 */
		override protected function getElementBoundsBelowScrollRect(scrollRect:Rectangle):Rectangle
		{
			var bounds:Rectangle = new Rectangle();
			// Find the row that spans or is below the scrollRect bottom edge
			var row:int = Math.floor((scrollRect.bottom + 1 + _verticalGap) / (_rowHeight + _verticalGap));
			bounds.top = topEdge(row);
			bounds.bottom = bottomEdge(row);
			return bounds;
		}
		
		/**
		 *  @private
		 */
		override public function elementAdded(index:int):void
		{
			invalidateTargetSizeAndDisplayList();
		}
		
		/**
		 *  @private
		 */
		override public function elementRemoved(index:int):void
		{
			invalidateTargetSizeAndDisplayList();
		}     
		
		//--------------------------------------------------------------------------
		//
		//  Drop methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private 
		 *  Calculates the column and row and returns the corrsponding cell index.
		 *  Index may be out of range if there's no element for the cell.
		 */
		private function calculateDropCellIndex(x:Number, y:Number):Array
		{
			var column:int = Math.floor(x / (_columnWidth + _horizontalGap));
			var row:int = Math.floor(y / (_rowHeight + _verticalGap));
			
			// Check whehter x is closer to left column or right column:
			var midColumnLine:Number;
			var midRowLine:Number
			
			var rowOrientation:Boolean = orientation == TileOrientation.ROWS;
			if (rowOrientation)
			{
				// Mid-line is at the middle of the cell
				midColumnLine = (column + 1) * (_columnWidth + _horizontalGap) - _horizontalGap - _columnWidth / 2; 
				
				// Mid-line is at the middle of the gap between the rows
				midRowLine = (row + 1) * (_rowHeight + _verticalGap) - _verticalGap / 2;  
			}
			else
			{
				// Mid-line is at the middle of the gap between the columns
				midColumnLine = (column + 1) * (_columnWidth + _horizontalGap) - _horizontalGap / 2;
				
				// Mid-line is at the middle of the cell
				midRowLine = (row + 1) * (_rowHeight + _verticalGap) - _verticalGap - _rowHeight / 2; 
			}
			
			if (x > midColumnLine)
				column++;
			if (y > midRowLine)
				row++;
			
			// Limit row and column, if any one is too far from the drop location
			// And there is white space
			if (column > _columnCount || row > _rowCount)
			{
				row = _rowCount;
				column = _columnCount;
			}
			
			if (column < 0)
				column = 0;
			if (row < 0)
				row = 0;
			
			var index:int;
			if (rowOrientation)
			{
				if (row >= _rowCount)
					row = _rowCount - 1;
			}
			else
			{
				if (column >= _columnCount)
					column = _columnCount - 1;
			}
			return [row, column];
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		override protected function calculateDropIndex(x:Number, y:Number):int
		{
			var result:Array = calculateDropCellIndex(x, y);
			var row:int = result[0]; 
			var column:int = result[1]; 
			var index:int;
			
			if (orientation == TileOrientation.ROWS)
				index = row * _columnCount + column;
			else
				index = column * _rowCount + row;
			
			var count:int = calculateElementCount();
			_numElementsCached = -1; // Reset the cache
			
			if (index > count)
				index = count;
			return index;
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		override protected function calculateDropIndicatorBounds(dropLocation:DropLocation):Rectangle
		{
			var result:Array = calculateDropCellIndex(dropLocation.dropPoint.x, dropLocation.dropPoint.y);
			var row:int = result[0]; 
			var column:int = result[1]; 
			
			var rowOrientation:Boolean = orientation == TileOrientation.ROWS;
			var count:int = calculateElementCount();
			_numElementsCached = -1; // Reset the cache
			
			if (rowOrientation)
			{
				// The last row may be only partially full,
				// don't drop beyond the last column.
				if (row * _columnCount + column > count)
					column = count - (_rowCount - 1) * _columnCount;
			}
			else
			{
				// The last column may be only partially full,
				// don't drop beyond the last row.
				if (column * _rowCount + row > count)
					row = count - (_columnCount - 1) * _rowCount;
			}
			
			var x:Number;
			var y:Number;
			var dropIndicatorElement:IVisualElement;
			var emptySpace:Number; // empty space between the elements
			
			// Start with the dropIndicator dimensions, in case it's not 
			// an IVisualElement
			var width:Number = dropIndicator.width;
			var height:Number = dropIndicator.height;
			
			if (rowOrientation)
			{
				emptySpace = (0 < _horizontalGap ) ? _horizontalGap : 0; 
				var emptySpaceLeft:Number = column * (_columnWidth + _horizontalGap) - emptySpace;
				
				// Special case - if we have negative gap and we're the last column,
				// adjust the emptySpaceLeft
				if (_horizontalGap < 0 && (column == _columnCount || count == dropLocation.dropIndex))
					emptySpaceLeft -= _horizontalGap;
				
				width = emptySpace;
				height = _rowHeight;
				// Special case - if we have negative gap and we're not the last
				// row, adjust the height
				if (_verticalGap < 0 && row < _rowCount - 1)
					height += _verticalGap + 1;
				
				if (dropIndicator is IVisualElement)
				{
					dropIndicatorElement = IVisualElement(dropIndicator);
					width = Math.max(Math.min(width,
						dropIndicatorElement.getMaxBoundsWidth(false)),
						dropIndicatorElement.getMinBoundsWidth(false));
				}
				
				x = emptySpaceLeft + Math.round((emptySpace - width) / 2);
				// Allow 1 pixel overlap with container border
				x = Math.max(-1, Math.min(target.contentWidth - width + 1, x));
				
				y = row * (_rowHeight + _verticalGap);
			}
			else
			{
				emptySpace = (0 < _verticalGap ) ? _verticalGap : 0; 
				var emptySpaceTop:Number = row * (_rowHeight + _verticalGap) - emptySpace;
				
				// Special case - if we have negative gap and we're the last column,
				// adjust the emptySpaceLeft
				if (_verticalGap < 0 && (row == _rowCount || count == dropLocation.dropIndex))
					emptySpaceTop -= _verticalGap;
				
				width = _columnWidth;
				height = emptySpace;
				// Special case - if we have negative gap and we're not the last
				// column, adjust the width
				if (_horizontalGap < 0 && column < _columnCount - 1)
					width += _horizontalGap + 1;
				
				if (dropIndicator is IVisualElement)
				{
					dropIndicatorElement = IVisualElement(dropIndicator);
					height = Math.max(Math.min(emptySpace,
						dropIndicatorElement.getMaxBoundsWidth(false)),
						dropIndicatorElement.getMinBoundsWidth(false));
				}
				
				x = column * (_columnWidth + _horizontalGap);
				
				y = emptySpaceTop + Math.round((emptySpace - height) / 2);
				// Allow 1 pixel overlap with container border
				y = Math.max(-1, Math.min(target.contentHeight - height + 1, y));
			}
			
			return new Rectangle(x, y, width, height);
		}
	}
}
