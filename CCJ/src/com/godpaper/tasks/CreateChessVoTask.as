package com.godpaper.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.business.factory.ChessFactory;
	import com.godpaper.model.ChessPiecesModel;
	import com.godpaper.model.vos.ConductVO;
	import com.godpaper.model.vos.OmenVO;
	import com.godpaper.views.components.ChessPiece;
	
	
	/**
	 * CreateChessVoTask.as class. include<conduct,omen,etc>  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Nov 30, 2010 12:04:11 PM
	 */   	 
	public class CreateChessVoTask extends Task
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
		public function CreateChessVoTask()
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
			//create chess pieces' conductVO;
			//create chess pieces' omenVO;
			for(var cp:int=0;cp<chessPiecesModel.pieces.length;cp++)
			{
				var chessPiece:ChessPiece = chessPiecesModel.pieces[cp];
				//generateChessPieceVO
				var conductVO:ConductVO = new ConductVO();
				conductVO.target = chessPiece;
				conductVO.previousPosition = chessPiece.position;
				chessPiece.chessVO = ChessFactory.generateChessVO(conductVO);
				//generateOmenVO
				var omenVO:OmenVO = ChessFactory.generateOmenVO(conductVO);
//				LOG.debug(omenVO.dump());
				chessPiece.omenVO = omenVO;
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