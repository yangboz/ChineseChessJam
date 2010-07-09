package com.lookbackon.ccj.managers
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.business.factory.ChessFactory;
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.ZobristKeysModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.ZobristKeyVO;
	import com.lookbackon.ccj.model.vos.cvo.ChessVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;
	
	import de.polygonal.ds.Array2;
	import de.polygonal.math.PM_PRNG;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.logging.ILogger;
	import mx.managers.DragManager;
	
	import spark.events.ElementExistenceEvent;
	import spark.filters.GlowFilter;

	/**
	 * The chess piece manager manage chess piece move's validation/makeMove/unMakeMove.
	 * 
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
		private static var _gaskets:Array2 = new Array2(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
		//
		private static var _conductsHistorys:Array = [];
		//But the real trick is if we do the XOR operation again we get the initial number back.
		//a ^ b = c
		//c ^ b = a
		private static var _crossOverValue:int;//and we using _crossOverValue for store the value "b";
		private static var _zKey:ZobristKeyVO;//current chess piece's zobrist key value object.
		//
		private static var chessPiecesModel:ChessPiecesModel = ChessPiecesModel.getInstance();
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
		public static function get gaskets():Array2
		{
			return _gaskets;
		}
		public static function set gaskets(value:Array2):void
		{
			_gaskets = value;
		}
		//----------------------------------
		//  conductsHistorys
		//----------------------------------
		public static function get conductsHistorys():Array
		{
			return _conductsHistorys;
		}
		public static function set conductsHistorys(value:Array):void
		{
			_conductsHistorys = value;
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
			result = Boolean(conductVO.target.chessVO.moves.getBitt(conductVO.previousPosition.y,conductVO.previousPosition.x));
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
			LOG.info("Begin makeMove:{0}",conductVO.brevity);
			//TODO:implement functions.
			//manually move chess pieces handler.;
//			var cGasketIndex:int = conductVO.nextPosition.y*CcjConstants.BOARD_H_LINES+conductVO.nextPosition.x;
//			trace(cGasketIndex.toString(),"cGasketIndex");
			var cGasket:ChessGasket = 
				ChessPieceManager.gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
			//hold gasket skin,then remove previous chess piece.
//			cGasket.dispatchEvent(new DragEvent(DragEvent.DRAG_ENTER,false,true,conductVO.target));
//			cGasket.dispatchEvent(new DragEvent(DragEvent.DRAG_DROP,false,true,conductVO.target));	
			if(cGasket.numElements>1)
			{
				//TODO:chess piece eat off.
				var removedPiece:ChessPiece = cGasket.getElementAt(1) as ChessPiece;
				var removedIndex:int = calculatePieceIndex(removedPiece);
				LOG.info("Eat Off@{0} target:{1}",cGasket.position.toString(),removedPiece.toString());
				if(ChessPiece(cGasket.getElementAt(1)).label==ChessPiecesConstants.BLUE_MARSHAL.label)
				{
					GameManager.humanWin();	
				}
				if(ChessPiece(cGasket.getElementAt(1)).label==ChessPiecesConstants.RED_MARSHAL.label)
				{
					GameManager.computerWin();
				}
				//clean this bit at pieces.
				BitBoard(ChessPiecesModel.getInstance()[removedPiece.type]).setBitt(removedPiece.position.y,removedPiece.position.x,false);
				//remove pieces data.
				if(GameManager.turnFlag==CcjConstants.FLAG_RED)
				{
					//clean this bit at bluePieces.
					chessPiecesModel.blues.removeItemAt(removedIndex);
				}else
				{
					//clean this bit at redPieces.
					chessPiecesModel.reds.removeItemAt(removedIndex);
				}
				//remove element from gasket.
				cGasket.removeElementAt(1);
			}
			//adjust the chess piece's position.
			conductVO.target.x = 0;
			conductVO.target.y = 0;
			//update conductsHistorys
			_crossOverValue = pmPRNG.nextInt();
			LOG.debug("_crossOverValue:{0}",_crossOverValue.toString());
			conductsHistorys.push({con:conductVO,cov:_crossOverValue});
			//update bitboard.
			updatePieceBitboard(conductVO);
			//update allPieces.
			updatePiecePosition(conductVO,cGasket);
			//update allPieces' chessVO.
			updateAllPiecesChessVO();
			//update ZobristKeys
//			updateZobristKeysModel(conductVO);
			//buffer here,after update all data,then refresh view.
			cGasket.addElement(conductVO.target as IVisualElement);
			//switch turn flag.
			if(GameManager.turnFlag==CcjConstants.FLAG_BLUE)
			{
				//indicate check.
				indicateCheck(chessPiecesModel.blues,chessPiecesModel.RED_MARSHAL);
				//
				GameManager.isHumanTurnNow();
			}else
			{
				//indicate check.
				indicateCheck(chessPiecesModel.reds,chessPiecesModel.BLUE_MARSHAL);
				//
				GameManager.isComputerTurnNow();
			}
			LOG.info("End makeMove:{0}",conductVO.brevity);
		}
		public static function unmakeMove():void
		{
			var conductHistory:* = conductsHistorys.pop();
			var conductVO:ConductVO = conductHistory["con"] as ConductVO;
			var _crossOverValue:int = conductHistory["cov"];
			var oX:int = conductVO.target.position.x;
			var oY:int = conductVO.target.position.y;
			var pX:int = conductVO.previousPosition.x;
			var pY:int = conductVO.previousPosition.y;
			//TODO:implement functions.
			//ref:http://mediocrechess.blogspot.com/2007/01/guide-zobrist-keys.html.
			_zKey = ZobristKeysModel.getInstance().getZobristKey();
			LOG.debug("before unmakemove:{0}",_zKey.dump());
			//update zobristkey.
			_zKey.position.sett(oX,oY,_crossOverValue^_zKey.position.gett(oX,oY) );
			_zKey.position.sett(pX,pY,_crossOverValue^_zKey.position.gett(pX,pY) );
			//
			LOG.debug("after unmakemove:{0}",_zKey.dump());
			//TODO:unmake updateAllPiecesPosition(based on game turn phase.)
			//
		}
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * 
		 */
		private static function updateZobristKeysModel(conductVO:ConductVO):void
		{
			//TODO:update ZobristKeys
			var pX:int = conductVO.previousPosition.x;
			var pY:int = conductVO.previousPosition.y;
			var oX:int = conductVO.nextPosition.x;
			var oY:int = conductVO.nextPosition.y;
			//ref:http://mediocrechess.blogspot.com/2007/01/guide-zobrist-keys.html
			_zKey = ZobristKeysModel.getInstance().getZobristKey();
			LOG.debug("before makemove:{0}",_zKey.dump());
			//update zobristkey.
			_zKey.position.sett(oX,oY,_crossOverValue^_zKey.position.gett(oX,oY) );
			_zKey.position.sett(pX,pY,_crossOverValue^_zKey.position.gett(pX,pY) );
			//
			LOG.debug("after makemove:{0}",_zKey.dump());
			//for testing unmakeMove();
//			unmakeMove();
		}
		/**
		 * @param conductVO the conduct value object of moving chess piece.
		 * @param gasket the chess piece's gasket.
		 */
		private static function updatePiecePosition(conductVO:ConductVO,gasket:ChessGasket):void
		{
			conductVO.target.position = gasket.position;
		}
		/**
		 * @param conductVO the conduct value object of moving chess piece.
		 */
		private static function updatePieceBitboard(conductVO:ConductVO):void
		{
			LOG.debug("before move,allPieces:{0}",ChessPiecesModel.getInstance().allPieces.dump());
			BitBoard(ChessPiecesModel.getInstance()[conductVO.target.type]).setBitt(conductVO.nextPosition.y,conductVO.nextPosition.x,true);
			BitBoard(ChessPiecesModel.getInstance()[conductVO.target.type]).setBitt(conductVO.previousPosition.y,conductVO.previousPosition.x,false);
			LOG.info("after move,allPieces:{0}",ChessPiecesModel.getInstance().allPieces.dump());
		}
		
		//	
		private static function updateAllPiecesChessVO():void
		{
			for(var i:int=0;i<chessPiecesModel.pieces.length;i++)
			{
				var chessPiece:ChessPiece = chessPiecesModel.pieces.getItemAt(i) as ChessPiece;
				//renew data.
				var currentConductVO:ConductVO = new ConductVO();
				currentConductVO.target = chessPiece;
//				LOG.info("before move,currentConductVO:{0}",currentConductVO.dump());
//				LOG.info("before move,chessPiece's chessVO's legal moves:{0}",chessPiece.chessVO.moves.dump());
				//renew chessVO.
				chessPiece.chessVO = ChessFactory.generateChessVO(currentConductVO);
//				LOG.info("after move,chessPiece's chessVO's legal moves:{0}",chessPiece.chessVO.moves.dump());
			}
			LOG.info("{0} Chess Pieces' ChessVO Updated !!!",chessPiecesModel.pieces.length.toString());
		}
		//notice:why not using ArrayCollection.getItemIndex(object)?
		//cuz our chess piece's position property always change here.
		private static function calculatePieceIndex(chessPiece:ChessPiece):int
		{
			for(var i:int=0;i<chessPiecesModel.reds.length;i++)
			{
				if(chessPiece.uid == ChessPiece(chessPiecesModel.reds.getItemAt(i)).uid)
				{
					return i;
				}
			}
			for(var j:int=0;j<chessPiecesModel.blues.length;j++)
			{
				if(chessPiece.uid == ChessPiece(chessPiecesModel.blues.getItemAt(j)).uid)
				{
					return j;
				}
			}
			throw new CcjErrors(CcjErrors.INVALID_CHESS_PIECE_INDEX);
			return -1;
		}
		/**
		 * 
		 * @param legalMoves current chess piece's legal moves.
		 * 
		 */		
		public static function indicatedGaskets(legalMoves:BitBoard):void
		{
			//@see Main.application1_creationCompleteHandler.createGasket.
			for(var v:int=0;v<CcjConstants.BOARD_V_LINES;v++)
			{
				for(var h:int=0;h<CcjConstants.BOARD_H_LINES;h++)
				{
					if(legalMoves.getBitt(v,h))
					{
						(ChessPieceManager.gaskets.gett(h,v) as ChessGasket).filters = [new GlowFilter()];
					}else
					{
						(ChessPieceManager.gaskets.gett(h,v) as ChessGasket).filters = [];
					}
				}
			}	
		}
		/**
		 * 
		 * @param pieces execute check mate's chess pieces.
		 * @param marshal blues'/reds' marshal bitboard.
		 * @return the result of check pattern,if neccessary.
		 * 
		 */		
		private static function indicateCheck(pieces:ArrayCollection,marshal:BitBoard):Boolean
		{
			//TODO:
			var totalCaptures:BitBoard = new BitBoard(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
			for(var i:int=0;i<pieces.length;i++)
			{
				totalCaptures = (pieces.getItemAt(i) as ChessPiece).chessVO.captures.or(totalCaptures);
			}
			LOG.debug("totalCaptures:{0}",totalCaptures.dump());
			if(!totalCaptures.and(marshal).isEmpty)
			{
//				GameManager.indicatorReadOut = true;
//				GameManager.indication = GameManager.INDICATION_CHECK;
				return true;
			}
			return false;
		}
	}
	
}
