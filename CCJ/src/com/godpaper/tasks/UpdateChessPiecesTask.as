package com.godpaper.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.managers.ChessPieceManager;
	import com.lookbackon.ccj.managers.GameManager;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;
	import mx.core.IVisualElement;
	
	/**
	 * UpdateChessPiecesTask.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 1:17:30 PM
	 */   	 
	public class UpdateChessPiecesTask extends Task
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
		private static const LOG:ILogger = LogUtil.getLogger(UpdateChessPiecesTask);
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
		public function UpdateChessPiecesTask(conductVO:ConductVO)
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
			//
			if(cGasket.numElements>=1)
			{
				//TODO:chess piece eat off.
				var removedPiece:ChessPiece = cGasket.getElementAt(0) as ChessPiece;
				var removedIndex:int = ChessPieceManager.calculatePieceIndex(removedPiece);
				LOG.info("Eat Off@{0} target:{1}",cGasket.position.toString(),removedPiece.toString());
				if(ChessPiece(cGasket.getElementAt(0)).label==ChessPiecesConstants.BLUE_MARSHAL.label)
				{
					GameManager.humanWin();	
				}
				if(ChessPiece(cGasket.getElementAt(0)).label==ChessPiecesConstants.RED_MARSHAL.label)
				{
					GameManager.computerWin();
				}
				//clean this bit at pieces.
				BitBoard(ChessPiecesModel.getInstance()[removedPiece.type]).setBitt(removedPiece.position.y,removedPiece.position.x,false);
				//set eat off value.
				ChessPieceManager.eatOffs.push(removedPiece);
				//remove pieces data.
				if(GameManager.turnFlag==CcjConstants.FLAG_RED)
				{
					//clean this bit at bluePieces.
					ChessPiecesModel.getInstance().blues.splice(removedIndex,1);
				}else
				{
					//clean this bit at redPieces.
					ChessPiecesModel.getInstance().reds.splice(removedIndex,1);
				}
				//remove element from gasket.
//				cGasket.removeElementAt(0);
				cGasket.chessPiece = null;
			}
			//adjust the chess piece's position.
			conductVO.target.x = 0;
			conductVO.target.y = 0;
			//
//			cGasket.addElement(conductVO.target as IVisualElement);
			cGasket.chessPiece = conductVO.target;
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