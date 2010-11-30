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
	import com.lookbackon.ccj.view.components.IChessPiece;
	
	import flash.geom.Point;
	
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
			for(var hh:int=0;hh<CcjConstants.BOARD_H_LINES;hh++)
			{
				for(var vv:int=0;vv<CcjConstants.BOARD_V_LINES;vv++)
				{
					var iChessPiece:IChessPiece = ChessFactory.createChessPiece(new Point(hh,vv));
					if(iChessPiece!=null)
					{
//						trace("index:",vv*CcjConstants.BOARD_V_LINES+hh);
						var ecGasket:ChessGasket = ChessPieceManager.gaskets.gett(hh,vv) as ChessGasket;
						ecGasket.addElement( iChessPiece );
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