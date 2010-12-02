package com.godpaper.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessPiece;
	
	import mx.logging.ILogger;
	
	import org.osmf.traits.ILoadable;
	
	
	/**
	 * UpdatePiecesOmenVoTask.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 1:43:27 PM
	 */   	 
	public class UpdatePiecesOmenVoTask extends Task
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var chessPiecesModel:ChessPiecesModel = ChessPiecesModel.getInstance();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(UpdatePiecesOmenVoTask);
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
		public function UpdatePiecesOmenVoTask()
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
			//TODO:
			for(var i:int=0;i<chessPiecesModel.pieces.length;i++)
			{
				var chessPiece:ChessPiece = chessPiecesModel.pieces[i];
				//renew chessVO.
				chessPiece.omenVO.flexibility  = chessPiece.chessVO.moves.celled;
				chessPiece.omenVO.threat  = chessPiece.chessVO.captures.celled;
			}
			LOG.info("{0} Chess Pieces' OmenVO Updated !!!",chessPiecesModel.pieces.length.toString());
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