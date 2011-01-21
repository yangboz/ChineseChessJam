package com.godpaper.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.configs.BoardConfig;
	import com.godpaper.consts.CcjConstants;
	import com.godpaper.business.factory.ChessFactory;
	import com.godpaper.business.managers.ChessPieceManager;
	import com.godpaper.views.components.ChessGasket;
	import com.godpaper.core.IChessPiece;
	
	import flash.geom.Point;
	
	import mx.core.FlexGlobals;
	
	/**
	 * CreateChessPieceTask.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Nov 30, 2010 12:00:05 PM
	 */   	 
	public class CreateChessPieceTask extends Task
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
		public function CreateChessPieceTask()
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
			//create chess piece
			for(var hh:int=0;hh<BoardConfig.xLines;hh++)
			{
				for(var vv:int=0;vv<BoardConfig.yLines;vv++)
				{
					var iChessPiece:IChessPiece = ChessFactory.createChessPiece(new Point(hh,vv));
					if(iChessPiece!=null)
					{
//						trace("index:",vv*CcjConstants.BOARD_V_LINES+hh);
						var ecGasket:ChessGasket = ChessPieceManager.gaskets.gett(hh,vv) as ChessGasket;
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