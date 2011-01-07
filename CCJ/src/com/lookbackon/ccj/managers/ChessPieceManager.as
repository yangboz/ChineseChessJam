package com.lookbackon.ccj.managers
{
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
	import com.lookbackon.ccj.model.ChessPiecesMemento;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.model.vos.ZobristKeyVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ccj.view.components.IChessPiece;
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
		private static var pmPRNG:PM_PRNG=new PM_PRNG();
		//
		private static var _gaskets:Array2=new Array2(CcjConstants.BOARD_H_LINES, CcjConstants.BOARD_V_LINES);
		//But the real trick is if we do the XOR operation again we get the initial number back.
		//a ^ b = c
		//c ^ b = a
//		private static var _crossOverValue:int;//and we using _crossOverValue for store the value "b";
		private static var _zKey:ZobristKeyVO; //current chess piece's zobrist key value object.
		//
		private static var chessPiecesModel:ChessPiecesModel=ChessPiecesModel.getInstance();
		//
		private static var _eatOffs:Vector.<ChessPiece>=new Vector.<ChessPiece>();
		//
//		private static var _memento:ChessPiecesMemento;
		private static var _conduct:ConductVO;
		//
		private static var _previousMementos:Array=[];
		private static var _nextMementos:Array=[];
		//flag is checked.
		[Bindable]
		private static var _isChecking:Boolean = false;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(ChessPieceManager);

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
			_conduct=value.conduct;
			//
			update();
		}

		//----------------------------------
		//  previousMementos
		//----------------------------------
		/**
		 * @return chess pieces' move history.
		 */
		public static function get previousMementos():Array
		{
			return _previousMementos;
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
			_gaskets=value;
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
			_eatOffs=value;
		}
		//----------------------------------
		//  isChecking
		//----------------------------------
		public static function get isChecking():Boolean
		{
			return _isChecking;
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
			var result:Boolean=true;
			//begin:
//			var beginTime:uint = new Date().getMilliseconds();
//			LOG.info("move validate begin at:{0}",beginTime);
			//chess piece change state(view).
//			conductVO.target.agent.getFSM().changeState(conductVO.target.attackState);
			//TODO:
			//chess piece move (logic) check.
			result=Boolean(conductVO.target.chessVO.moves.getBitt(conductVO.previousPosition.y, conductVO.previousPosition.x));
//			LOG.info("doMoveValidation result:{0}",result);
			//end
//			var endTime:uint = new Date().getMilliseconds();
//			LOG.info("move validate end at:{0}||duration:{1}",endTime,endTime-beginTime);
			return result;
		}

		/**
		 * <b>Make Move</b> is a function inside a chess program to update the internal chess position
		 * and its Board representation as well as associated </br>
		 * or dependent state variables and data by a move made on the internal board,
		 * such as zobrist keys to index the transposition table. </br>
		 * That usually happens inside the Search algorithm, </br>
		 * where the move acts like an edge connecting two nodes of a search tree,
		 * a parent and a child node. </br>
		 * Dependent on the design of the data structures
		 * and the used search algorithms there are different approaches
		 * with respect to randomly accessing aspects of nodes
		 * and restoring the position while unmaking the move.
		 *
		 * @see http://chessprogramming.wikispaces.com/Make+Move
		 * @param conductVO the conduct value object of moving chess piece.
		 *
		 */
		public static function makeMove(conductVO:ConductVO):void
		{
			LOG.info("Begin makeMove:{0}", conductVO.brevity);
			//update conduct
			_conduct=conductVO;
			_conduct.crossValue=pmPRNG.nextInt();
			LOG.debug("crossOverValue:{0}", conductVO.crossValue.toString());
			//update mememto
			var memento:ChessPiecesMemento=new ChessPiecesMemento(conductVO);
			_nextMementos=[];
			_previousMementos.push(memento);
			ChessPieceManager.memento=memento;
			//
			LOG.info("End makeMove:{0}", conductVO.brevity);
			//Trigger in-turn system .
			if (GameManager.isRunning)
			{
				if (GameManager.turnFlag == CcjConstants.FLAG_RED)
				{
					GameManager.isComputerTurnNow();
				}
				else
				{
					GameManager.isHumanTurnNow();
				}
			}
		}

		/**
		 *
		 * <b>Unmake Move</b> is a function inside a chess program to update the internal chess position
		 * and its Board representation as well as associated or dependent state variables
		 * and data by a move unmade on the internal board. </br>
		 * In unmake move, reversible aspects of a position can be incrementally updated by the inverse
		 * or own inverse operation of Make Move. </br>
		 * Irreversible aspects of a position, such as ep state,
		 * castling rights and the halfmove clock are either restored from a stack (LIFO), </br>
		 * or simply kept in arrays indexed by current search or game ply. </br>
		 * Alternatively, one may capacitate the move with all the necessary information
		 * to recover those irreversible aspects of a position as well.
		 *
		 * @see http://chessprogramming.wikispaces.com/Unmake+Move
		 *
		 * @param conductVO the conduct value object of moving chess piece.
		 *
		 */
		//
		public static function unmakeMove(conductVO:ConductVO):void
		{
			var reversedConductVO:ConductVO=conductVO.reverse();
			LOG.info("Begin unmakeMove:{0}", reversedConductVO.brevity);
			//reverse conductVO to unmakeMove.
			var eattenPiece:IChessPiece;
			if (null != conductVO.eatOff)
			{
				//thrown out the eatten piece;
				eattenPiece=eatOffs.pop() as IChessPiece;
				//roll back the eatting piece;
				var cGasket:ChessGasket=ChessPieceManager.gaskets.gett(eattenPiece.position.x, eattenPiece.position.y);
//				cGasket.addElement(eattenPiece);
				cGasket.chessPiece=eattenPiece;
			}
			//TODO:un-update functions.
			//roll back bitboard
			if (null != eattenPiece)
			{
				BitBoard(chessPiecesModel[eattenPiece.type]).setBitt(cGasket.position.y, cGasket.position.x, true);
			}
			//
			LOG.debug(chessPiecesModel.allPieces.dump());
			//roll back pieces data.
			if (GameManager.turnFlag == CcjConstants.FLAG_RED)
			{
				chessPiecesModel.blues.push(eattenPiece);
			}
			else
			{
				chessPiecesModel.reds.push(eattenPiece);
			}
			//update mememto(unmake)
			var mememto:ChessPiecesMemento;
			if (_previousMementos.length > 0)
			{
				mememto=_previousMementos.pop();
				mememto.conduct=mememto.conduct.reverse();
				_nextMementos.push(mememto);
				ChessPieceManager.memento=mememto;
			}
			//
			LOG.info("End unmakeMove:{0}", reversedConductVO.brevity);
			//update mememto(remake)
//			if(_nextMementos.length > 0) {
//				memento = _nextMementos.pop();
//				_previousMementos.push(memento);
//				ChessPieceManager.memento = mememto;
//			}
		}

		//make move data and piece entity change behavior.
		public static function applyMove(conductVO:ConductVO):void
		{
			//TODO:with roll back function support.
			var cGasket:ChessGasket=ChessPieceManager.gaskets.gett(conductVO.nextPosition.x, conductVO.nextPosition.y) as ChessGasket;
			if (cGasket.numElements >= 1)
			{
				//TODO:chess piece eat off.
				var removedPiece:ChessPiece=cGasket.getElementAt(0) as ChessPiece;
				var removedIndex:int=ChessPieceManager.calculatePieceIndex(removedPiece);
				LOG.info("Eat Off@{0} target:{1}", cGasket.position.toString(), removedPiece.toString());
				if (ChessPiece(cGasket.getElementAt(0)).label == ChessPiecesConstants.BLUE_MARSHAL.label)
				{
					GameManager.humanWin();
				}
				if (ChessPiece(cGasket.getElementAt(0)).label == ChessPiecesConstants.RED_MARSHAL.label)
				{
					GameManager.computerWin();
				}
				//clean this bit at pieces.
				BitBoard(ChessPiecesModel.getInstance()[removedPiece.type]).setBitt(removedPiece.position.y, removedPiece.position.x, false);
				//remove pieces data.
				if (GameManager.turnFlag == CcjConstants.FLAG_RED)
				{
					//clean this bit at bluePieces.
					//notice array splice without copy
//					chessPiecesModel.blues = 
					chessPiecesModel.blues.splice(removedIndex, 1);
				}
				else
				{
					//clean this bit at redPieces.
					//notice array splice without copy
//					chessPiecesModel.reds = 
					chessPiecesModel.reds.splice(removedIndex, 1);
				}
				//remove element from gasket.
//				cGasket.removeElementAt(0);
				cGasket.chessPiece=null;
			}
			//
			makeMove(conductVO);
		}

		//pluge to death.	
		public static function noneMove():int
		{
			if (GameManager.turnFlag == CcjConstants.FLAG_BLUE)
			{
				GameManager.humanWin();
			}
			else
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
			for (var i:int=0; i < chessPiecesModel.reds.length; i++)
			{
				if (chessPiece.uid == ChessPiece(chessPiecesModel.reds[i]).uid)
				{
					return i;
				}
			}
			for (var j:int=0; j < chessPiecesModel.blues.length; j++)
			{
				if (chessPiece.uid == ChessPiece(chessPiecesModel.blues[j]).uid)
				{
					return j;
				}
			}
			throw new CcjErrors(CcjErrors.INVALID_CHESS_PIECE_INDEX);
			return -1;
		}

		/**
		 * @see Main.application1_creationCompleteHandler.createGasket.
		 * @param legalMoves current chess piece's legal moves.
		 *
		 */
		public static function indicateGaskets(legalMoves:BitBoard):void
		{
			//@see Main.application1_creationCompleteHandler.createGasket.
			for (var v:int=0; v < CcjConstants.BOARD_V_LINES; v++)
			{
				for (var h:int=0; h < CcjConstants.BOARD_H_LINES; h++)
				{
					if (legalMoves.getBitt(v, h))
					{
						(ChessPieceManager.gaskets.gett(h, v) as ChessGasket).filters=[new GlowFilter()];
					}
					else
					{
						(ChessPieceManager.gaskets.gett(h, v) as ChessGasket).filters=[];
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
		public static function indicateCheck(pieces:Vector.<ChessPiece>, marshal:BitBoard):Boolean
		{
			//TODO:
			var totalCaptures:BitBoard=new BitBoard(CcjConstants.BOARD_H_LINES, CcjConstants.BOARD_V_LINES);
			for (var i:int=0; i < pieces.length; i++)
			{
				totalCaptures=pieces[i].chessVO.captures.or(totalCaptures);
			}
			LOG.debug("totalCaptures:{0}", totalCaptures.dump());
			if (!totalCaptures.and(marshal).isEmpty)
			{
				GameManager.indicatorCheck=true;
				//
				_isChecking = true;
				//
				return true;
			}
			//
			_isChecking = false;
			//
			return false;
		}

		/**
		 *
		 * @param gamePosition the current blue/red game position.
		 * @return whether or not blue/red check mated.
		 *
		 */
		private static function indicateCheckmate(gamePosition:PositionVO):Boolean
		{
			var checkmated:Boolean;
			if (gamePosition.color == CcjConstants.FLAG_BLUE)
			{
				checkmated=ChessPiecesModel.getInstance().BLUE_MARSHAL.isEmpty;
			}
			else
			{
				checkmated=ChessPiecesModel.getInstance().RED_MARSHAL.isEmpty;
			}
			return checkmated;
		}

		//update-relatived tasks here.
		private static function update():void
		{
			var task:ParallelTask=new ParallelTask();
			//
			//update bitboard.
			//update allPieces.
			//update allPieces' chessVO.
			//update allPieces' omenVO.
			//update ZobristKeys
			//buffer here,after update all data,then refresh view.
			task.addChild(new UpdatePiecesBitboardTask(memento.conduct));
			task.addChild(new UpdatePiecesPositionTask(memento.conduct));
			task.addChild(new UpdateZobristKeysTask(memento.conduct));
			task.addChild(new UpdatePiecesChessVoTask());
			task.addChild(new UpdatePiecesOmenVoTask());
			//
			task.addChild(new UpdateChessPiecesTask(memento.conduct));
			//
			task.start();
		}
	}

}
