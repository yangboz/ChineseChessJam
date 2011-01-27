package com.godpaper.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.business.factory.ChessFactoryBase;
	import com.godpaper.core.IChessFactory;
	import com.godpaper.business.managers.ChessPieceManager;
	import com.godpaper.configs.BoardConfig;
	import com.godpaper.consts.CcjConstants;
	import com.godpaper.model.ChessGasketsModel;

	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;

	import spark.components.Application;

	/**
	 * CreateChessGasketTask.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Nov 30, 2010 11:54:25 AM
	 */   	 
	public class CreateChessGasketTask extends ChessTaskBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function CreateChessGasketTask()
		{
			//TODO: implement function
			super();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function performTask():void
		{
			var className:String = getQualifiedClassName(factory);
			var implementation:Object = getDefinitionByName(className);
			var realFactoy:IChessFactory  = new implementation();
			//create chess gaskets.
			for(var v:int=0;v<BoardConfig.yLines;v++)
			{
				for(var h:int=0;h<BoardConfig.xLines;h++)
				{
					var cGasket:IVisualElement = 
						FlexGlobals.topLevelApplication.addElement( realFactoy.createChessGasket(new Point(h,v)) );
					//
					ChessGasketsModel.getInstance().gaskets.sett(h,v,cGasket);
				}
			}
			//mochi uicomponent at the top of game ui.
			FlexGlobals.topLevelApplication.setElementIndex(
				FlexGlobals.topLevelApplication.mochiUIComponent,
				FlexGlobals.topLevelApplication.numElements-1
				);
			//
			this.complete();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}

