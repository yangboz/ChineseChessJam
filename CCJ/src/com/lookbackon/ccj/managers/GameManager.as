package com.lookbackon.ccj.managers
{
	import com.lookbackon.AI.searching.ISearchingBase;
	import com.lookbackon.AI.searching.MinMax;
	import com.lookbackon.AI.searching.SearchingBase;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.HistoryTableModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.utils.MathUtil;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ccj.view.components.ThinkingProgressBar;
	
	import de.polygonal.ds.Array2;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.logging.ILogger;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;

	/**
	 * A player manager class to maintain turn-based game.
	 * 
	 * @author knight.zhou
	 * 
	 */	
	public class GameManager
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var searching:ISearchingBase;
		private static var iThinkingProgressBar:IFlexDisplayObject;
		private static var gameAI:ISearchingBase;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(GameManager);
		//generation.
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static function startGame():void
		{
			//TODO:
			//logic condition who's turn now at first.
			isComputerTurnNow();
		}
		//----------------------------------
		//  computerWin
		//----------------------------------
		public static function computerWin():void
		{
			//TODO:
			Alert.show("COMPUTER WIN!!!");
		}
		//----------------------------------
		//  humanWin
		//----------------------------------
		public static function humanWin():void
		{
			//TODO:
			Alert.show("HUMAN WIN!!!");
		}
		//----------------------------------
		//  isComputerTurnNow
		//----------------------------------
		public static function isComputerTurnNow():void
		{
			//TODO:
			//about view
			CursorManager.setBusyCursor();
			//
			iThinkingProgressBar = 
				PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,ThinkingProgressBar,true);
			PopUpManager.centerPopUp(iThinkingProgressBar);
			//about data
			var conductVO:ConductVO = new ConductVO();
			conductVO.target = ChessPieceManager.pieces.getItemAt(MathUtil.transactRandomNumberInRange(0,ChessPieceManager.pieces.length-1)) as ChessPiece;
			conductVO.newPosition = new Point(3,1);
			ChessPieceManager.makeMove(conductVO);
			//TODO:
			gameAI = new SearchingBase(new Array2(10,9));
			gameAI.generateMoves(ChessPiecesModel.getInstance().redPieces,HistoryTableModel.getInstance().redRook);
		}
		//----------------------------------
		//  isHumanTurnNow
		//----------------------------------
		public static function isHumanTurnNow():void
		{
			//TODO:
			//about view
			CursorManager.removeBusyCursor();
			//
			if(iThinkingProgressBar!=null)
			{
				PopUpManager.removePopUp(iThinkingProgressBar);
				iThinkingProgressBar = null;
			}
			//about data
			
		}
		
	}
}