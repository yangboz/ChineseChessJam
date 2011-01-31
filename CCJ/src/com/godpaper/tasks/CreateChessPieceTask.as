package com.godpaper.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.business.factory.ChessFactoryBase;
	import com.godpaper.business.managers.ChessPieceManager;
	import com.godpaper.configs.BoardConfig;
	import com.godpaper.consts.CcjConstants;
	import com.godpaper.core.IChessFactory;
	import com.godpaper.core.IChessPiece;
	import com.godpaper.model.ChessGasketsModel;
	import com.godpaper.views.components.ChessGasket;
	
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.FlexGlobals;

	/**
	 * ChessTaskBase.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Nov 30, 2010 12:00:05 PM
	 */   	 
	public class CreateChessPieceTask extends ChessTaskBase
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
		public function CreateChessPieceTask(factory:Class=null)
		{
			//TODO: implement function
			super();
			//
			this.factory = factory;
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
			//create chess piece
			for(var hh:int=0;hh<BoardConfig.xLines;hh++)
			{
				for(var vv:int=0;vv<BoardConfig.yLines;vv++)
				{
					var iChessPiece:IChessPiece = realFactoy.createChessPiece(new Point(hh,vv));
					if(iChessPiece!=null)
					{
//						trace("index:",vv*CcjConstants.BOARD_V_LINES+hh);
						var ecGasket:ChessGasket = ChessGasketsModel.getInstance().gaskets.gett(hh,vv) as ChessGasket;
						ecGasket.chessPiece = iChessPiece;
//						ecGasket.addElement( iChessPiece );
						//
						iChessPiece.x = 0;
						iChessPiece.y = 0;
							//
					}
				}
			}
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

