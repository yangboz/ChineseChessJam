package com.lookbackon.ccj.managers
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.ZobristKeysModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.ZobristKeyVO;
	import com.lookbackon.ccj.model.vos.cvo.ChessVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	
	import de.polygonal.math.PM_PRNG;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.logging.ILogger;
	import mx.managers.DragManager;

	/**
	 * The chess piece manager manage chess piece move's validation.
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessPieceManager
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var pmPRNG:PM_PRNG = new PM_PRNG();
		//
		private static var _pieces:ArrayCollection = new ArrayCollection();
		private static var _gaskets:ArrayCollection = new ArrayCollection();
		private static var _redPieces:ArrayCollection = new ArrayCollection();
		private static var _bluePieces:ArrayCollection = new ArrayCollection();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessPieceManager);
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  gaskets
		//----------------------------------
		public static function get gaskets():ArrayCollection
		{
			return _gaskets;
		}
		public static function set gaskets(value:ArrayCollection):void
		{
			_gaskets = value;
		}
		//----------------------------------
		//  pieces
		//----------------------------------
		public static function get pieces():ArrayCollection
		{
			return _pieces;
		}
		public static function set pieces(value:ArrayCollection):void
		{
			_pieces = value;
		}
		//----------------------------------
		//  redPieces
		//----------------------------------
		public static function get redPieces():ArrayCollection
		{
			return _redPieces;
		}
		//----------------------------------
		//  bluePieces
		//----------------------------------
		public static function get bluePieces():ArrayCollection
		{
			return _bluePieces;
		}
		//generation.
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * @return current chess piece's move validation result.
		 * 
		 */		
		public static function doMoveValidation(conductVO:ConductVO):Boolean
		{
			var result:Boolean = true;
			//begin:
//			var beginTime:uint = new Date().getMilliseconds();
//			LOG.info("move validate begin at:{0}",beginTime);
			//chess piece change state(view).
//			conductVO.target.agent.getFSM().changeState(conductVO.target.attackState);
			//TODO:
			//chess piece move (logic) check.
			result = Boolean(conductVO.target.chessVO.moves.getBitt(conductVO.newPosition.y,conductVO.newPosition.x));
//			LOG.info("doMoveValidation result:{0}",result);
			//end
//			var endTime:uint = new Date().getMilliseconds();
//			LOG.info("move validate end at:{0}||duration:{1}",endTime,endTime-beginTime);
			return result;
		}
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * 
		 */		
		public static function makeMove(conductVO:ConductVO):void
		{
			//TODO:implement functions.
			//manually move chess pieces handler.;
			var cGasketIndex:int = conductVO.newPosition.y*CcjConstants.BOARD_H_LINES+conductVO.newPosition.x;
//			trace(cGasketIndex.toString(),"cGasketIndex");
			var cGasket:ChessGasket = 
				ChessPieceManager.gaskets.getItemAt(cGasketIndex) as ChessGasket;
			//hold gasket skin,then remove previous chess piece.
//			cGasket.dispatchEvent(new DragEvent(DragEvent.DRAG_ENTER,false,true,conductVO.target));
//			cGasket.dispatchEvent(new DragEvent(DragEvent.DRAG_DROP,false,true,conductVO.target));	
			if(cGasket.numElements>1)
			{
				cGasket.removeElementAt(1);
			}
			cGasket.addElement(conductVO.target as IVisualElement);
			//adjust the chess piece's position.
			conductVO.target.x = 0;
			conductVO.target.y = 0;
			//update allPieces.
			updateAllPiecesPosition(conductVO);
			//update ZobristKeys
//			updateZobristKeysModel(conductVO);
			//switch turn flag.
			GameManager.isHumanTurnNow();
		}
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * 
		 */
		private static function updateZobristKeysModel(conductVO:ConductVO):void
		{
			//TODO:update ZobristKeys
			var zKeyVO:ZobristKeyVO = new ZobristKeyVO();
			var pX:int = conductVO.newPosition.x;
			var pY:int = conductVO.newPosition.y;
			LOG.debug("before move:{0}",ZobristKeysModel.getInstance().redRook.dump());
			if(conductVO.target.flag==CcjConstants.FLAG_RED)
			{
				ZobristKeysModel.getInstance().redRook.position.sett(pX,pY,
					pmPRNG.nextInt()^ZobristKeysModel.getInstance().redRook.position.gett(pX,pY) );
			}else
			{
				ZobristKeysModel.getInstance().redRook.position.sett(pX,pY,
					pmPRNG.nextInt()^ZobristKeysModel.getInstance().redRook.position.gett(pX,pY) );
			}
			LOG.debug("after move:{0}",ZobristKeysModel.getInstance().redRook.dump());
		}
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * 
		 */
		private static function updateAllPiecesPosition(conductVO:ConductVO):void
		{
			LOG.debug("before move,allPieces:{0}",ChessPiecesModel.getInstance().allPieces.dump());
			if(GameManager.turnFlag==CcjConstants.FLAG_BLUE)
			{
				ChessPiecesModel.getInstance().bluePieces.setBitt(conductVO.target.position.y,conductVO.target.position.x,false);
				ChessPiecesModel.getInstance().bluePieces.setBitt(conductVO.newPosition.y,conductVO.newPosition.x,true);
			}else
			{
				ChessPiecesModel.getInstance().redPieces.setBitt(conductVO.target.position.y,conductVO.target.position.x,false);
				ChessPiecesModel.getInstance().redPieces.setBitt(conductVO.newPosition.y,conductVO.newPosition.x,true);
			}
			LOG.debug("after move,allPieces:{0}",ChessPiecesModel.getInstance().allPieces.dump());
		}
	}
}