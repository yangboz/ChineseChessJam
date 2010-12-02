package com.godpaper.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.lookbackon.ccj.managers.ChessPieceManager;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessGasket;
	
	import mx.logging.ILogger;
	
	
	/**
	 * UpdatePiecesPostionTask.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 1:14:27 PM
	 */   	 
	public class UpdatePiecesPositionTask extends Task
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var conductVO:ConductVO;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(UpdatePiecesPositionTask);
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
		public function UpdatePiecesPositionTask(conductVO:ConductVO)
		{
			//TODO: implement function
			super();
			//
			this.conductVO = conductVO;
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
			//TODO:
			var cGasket:ChessGasket = 
				ChessPieceManager.gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
			this.conductVO.target.position = cGasket.position;
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