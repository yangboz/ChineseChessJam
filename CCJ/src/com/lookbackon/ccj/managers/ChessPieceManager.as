package com.lookbackon.ccj.managers
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.task.ParallelTask;
	import com.godpaper.tasks.UpdateChessPiecesTask;
	import com.godpaper.tasks.UpdatePiecesBitboardTask;
	import com.godpaper.tasks.UpdatePiecesChessVoTask;
	import com.godpaper.tasks.UpdatePiecesOmenVoTask;
	import com.godpaper.tasks.UpdatePiecesPositionTask;
	import com.godpaper.tasks.UpdateZobristKeysTask;
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.events.GameEvent;
	import com.lookbackon.ccj.model.ChessPiecesMemento;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.model.vos.ZobristKeyVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;
	
	import de.polygonal.ds.Array2;
	import de.polygonal.math.PM_PRNG;
	
	import mx.logging.ILogger;
	
	import spark.filters.GlowFilter;

	/**
	 * The chess piece manager manage chess piece move's validation/makeMove/unMakeMove.
	 * Also a way for the originator to be responsible for saving and restoring its states.
	 * @author Knight.zhou
	 * @history 2010-12-02 using memento design pattern to implment make/unmake functions.
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
		private static var _conductsHistorys:Vector.<ConductVO> = new Vector.<ConductVO>();
		//But the real trick is if we do the XOR operation again we get the initial number back.
		//a ^ b = c
		//c ^ b = a
//		private static var _crossOverValue:int;//and we using _crossOverValue for store the value "b";
		private static var _zKey:ZobristKeyVO;//current chess piece's zobrist key value object.
		//
		private static var chessPiecesModel:ChessPiecesModel = ChessPiecesModel.getInstance();
		//
		private static var _eatOffs:Vector.<ChessPiece> = new Vector.<ChessPiece>();
		//
//		private static var _memento:ChessPiecesMemento;
		private static var _conduct:ConductVO;
		//
		private static var _previousMementos:Array=[];
		private static var _nextMementos:Array=[];
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
		//  memento
		//----------------------------------
		public static function get memento():ChessPiecesMemento
		{
			return new ChessPiecesMemento(_conduct);
		}
		public static function set memento(value:ChessPiecesMemento):void
		{
			_conduct = value.conduct;
			//
			update();
		}
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
		public static function get conductsHistorys():Vector.<ConductVO>
		{
			return _conductsHistorys;
		}
		public static function set conductsHistorys(value:Vector.<ConductVO>):void
		{
			_conductsHistorys = value;
		}
		//----------------------------------
		//  eatOffs
		//----------------------------------
		public static function get eatOffs():Vector.<ChessPiece>
		{
			return _eatOffs;
		}
		public static function set eatOffs(value:Vector.<ChessPiece>):void
		{
			_eatOffs = value;
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
			//update conduct
			_conduct = conductVO;
			_conduct.crossValue = pmPRNG.nextInt();
			LOG.debug("crossOverValue:{0}",conductVO.crossValue.toString());
			conductsHistorys.push(conductVO);
			//update mememto
			_nextMementos = [];
			_previousMementos.push(conductVO);
			ChessPieceManager.memento = new ChessPiecesMemento(conductVO);
			//
			LOG.info("End makeMove:{0}",conductVO.brevity);
			//Trigger in-turn system .
			if(GameManager.turnFlag==CcjConstants.FLAG_RED)
			{
				CairngormEventDispatcher.getInstance().dispatchEvent(new GameEvent(GameEvent.IS_COMPUTER_TURN_NOW));
			}else
			{
				CairngormEventDispatcher.getInstance().dispatchEvent(new GameEvent(GameEvent.IS_HUMAN_TURN_NOW));
			}
		}
		//
		public static function unmakeMove(conductVO:ConductVO):void
		{
			var reversedConductVO:ConductVO = new ConductVO();
			reversedConductVO.crossValue = conductVO.crossValue;
			reversedConductVO.nextPosition = conductVO.previousPosition;
			reversedConductVO.previousPosition = conductVO.nextPosition;
			reversedConductVO.target = conductVO.target;
			reversedConductVO.eatOff = conductVO.eatOff;
			LOG.info("Begin unmakeMove:{0}",reversedConductVO.brevity);
			//reverse conductVO to unmakeMove.
			if(null!=conductVO.eatOff)
			{
				eatOffs.pop();
			}
			//TODO:un-update functions.
			makeMove(reversedConductVO);
			LOG.info("End unmakeMove:{0}",reversedConductVO.brevity);
			//update mememto(unmake)
			var mememto:ChessPiecesMemento;
			if(_previousMementos.length>0)
			{
				mememto = _previousMementos.pop();
				_nextMementos.push(mememto);
				ChessPieceManager.memento = mememto;
			}
			//update mememto(remake)
//			if(_nextMementos.length > 0) {
//				memento = _nextMementos.pop();
//				_previousMementos.push(memento);
//				ChessPieceManager.memento = mememto;
//			}
		}
		//
		public static function applyMove(conductVO:ConductVO):void
		{
			//TODO:
			var cGasket:ChessGasket = 
				ChessPieceManager.gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
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
				//remove pieces data.
				if(GameManager.turnFlag==CcjConstants.FLAG_RED)
				{
					//clean this bit at bluePieces.
					//notice array splice without copy
//					chessPiecesModel.blues = 
						chessPiecesModel.blues.splice(removedIndex,1);
				}else
				{
					//clean this bit at redPieces.
					//notice array splice without copy
//					chessPiecesModel.reds = 
						chessPiecesModel.reds.splice(removedIndex,1);
				}
				//remove element from gasket.
				cGasket.removeElementAt(0);
			}
			//
			makeMove(conductVO);
		}
		//pluge to death.	
		public static function noneMove():int
		{
			if(GameManager.turnFlag==CcjConstants.FLAG_BLUE)
			{
				GameManager.humanWin();
			}else
			{
				GameManager.computerWin();
			}
			return -1;
		}
		public static function willNoneMove(gamePosition:PositionVO):Boolean
		{
			//TODO:
			return false;
		}
		//notice:why not using ArrayCollection.getItemIndex(object)?
		//cuz our chess piece's position property always change here.
		public static function calculatePieceIndex(chessPiece:ChessPiece):int
		{
			for(var i:int=0;i<chessPiecesModel.reds.length;i++)
			{
				if(chessPiece.uid == ChessPiece(chessPiecesModel.reds[i]).uid)
				{
					return i;
				}
			}
			for(var j:int=0;j<chessPiecesModel.blues.length;j++)
			{
				if(chessPiece.uid == ChessPiece(chessPiecesModel.blues[j]).uid)
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
		private static function indicateCheck(pieces:Vector.<ChessPiece>,marshal:BitBoard):Boolean
		{
			//TODO:
			var totalCaptures:BitBoard = new BitBoard(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
			for(var i:int=0;i<pieces.length;i++)
			{
				totalCaptures = pieces[i].chessVO.captures.or(totalCaptures);
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
		/**
		 * 
		 * @param gamePosition the current blue/red game position.
		 * @return whether or not blue/red check mated.
		 * 
		 */		
		public static function indicateCheckmate(gamePosition:PositionVO):Boolean
		{
			var checkmated:Boolean;
			if(gamePosition.color==CcjConstants.FLAG_BLUE)
			{
				checkmated = ChessPiecesModel.getInstance().BLUE_MARSHAL.isEmpty;
			}else
			{
				checkmated = ChessPiecesModel.getInstance().RED_MARSHAL.isEmpty;
			}
			return checkmated;
		}
		//
		private static function update():void
		{
			var task:ParallelTask = new ParallelTask();
			//
			//update bitboard.
			//update allPieces.
			//update allPieces' chessVO.
			//update allPieces' omenVO.
			//update ZobristKeys
			//buffer here,after update all data,then refresh view.
			task.addChild(new UpdatePiecesBitboardTask(_conduct));
			task.addChild(new UpdatePiecesPositionTask(_conduct));
			task.addChild(new UpdateZobristKeysTask(_conduct));
			task.addChild(new UpdatePiecesChessVoTask());
			task.addChild(new UpdatePiecesOmenVoTask());
			//
			task.addChild(new UpdateChessPiecesTask(_conduct));
			//
			task.start();
		}
	}
	
}
