package com.godpaper.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.managers.ChessPieceManager;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ccj.view.components.IChessPiece;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mx.core.FlexGlobals;
	
	/**
	 * CleanUpChessPieceTask.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 29, 2010 11:51:40 AM
	 */   	 
	public class CleanUpChessPieceTask extends Task
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
		public function CleanUpChessPieceTask()
		{
			//TODO: implement function
			super();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override protected function performTask():void
		{
			//clean up chess piece
			for(var v:int=0;v<CcjConstants.BOARD_V_LINES;v++)
			{
				for(var h:int=0;h<CcjConstants.BOARD_H_LINES;h++)
				{
					var chessGasket:ChessGasket = (ChessPieceManager.gaskets.gett(h,v) as ChessGasket);
					if( chessGasket.chessPiece )
					{
						trace("removed piece:",ChessPiece(chessGasket.chessPiece).label );
						try{
							chessGasket.removeElement( chessGasket.chessPiece );
						}catch(error:Error)
						{
							//
							trace(error);
						}
					}
				}
			}
			//
			this.complete();
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}