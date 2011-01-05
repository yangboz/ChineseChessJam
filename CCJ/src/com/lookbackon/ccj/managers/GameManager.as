package com.lookbackon.ccj.managers
{
	import com.adobe.cairngorm.task.SequenceTask;
	import com.godpaper.tasks.CleanUpChessPieceTask;
	import com.godpaper.tasks.CleanUpPiecesBitboardTask;
	import com.godpaper.tasks.CreateChessPieceTask;
	import com.godpaper.tasks.CreateChessVoTask;
	import com.lookbackon.AI.searching.AttackFalse;
	import com.lookbackon.AI.searching.MiniMax;
	import com.lookbackon.AI.searching.RandomWalk;
	import com.lookbackon.AI.searching.ShortSighted;
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.business.fsm.GameAgent;
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.utils.LogUtil;
	
	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;
	import mx.logging.ILogger;

	/**
	 * A player manager class to maintain turn-based game.
	 *
	 * @author Knight.zhou
	 *
	 */
	public class GameManager
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var _turnFlag:int=CcjConstants.FLAG_BLUE;
		//toll gate setting here.
		private static var _tollgates:Array=[RandomWalk, ShortSighted, AttackFalse, MiniMax];
		//
		public static var isRunning:Boolean;
		//indicators
		[Bindable]
		public static var indicatorReadOut:Boolean=false;
		[Bindable]
		public static var indication:String=INDICATION_THINKING;
		//about mochi
		[Bindable]
		public static var indicatorSubmitScore:Boolean=false;
		//
		public static var agent:GameAgent;
		//
		private static var _level:int=1;
		//
		public static var tollgateTips:Array = ["baby intelligence","fellow intelligence","man intelligence","guru intelligence"];
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(GameManager);
		public static const INDICATION_THINKING:String="Thinking..";
		public static const INDICATION_CHECK:String="Eschequier";
		//game phase
		//Masks for bits inside the 'flags' var
		//which store the state of Boolean game phase properties.
		public static const PHASE_OPENING:uint=1 << 0;
		public static const PHASE_MIDDLE:uint=1 << 1;
		public static const PHASE_ENDING:uint=1 << 2;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  turnFlag(read-write)
		//----------------------------------
		public static function set turnFlag(value:int):void
		{
			_turnFlag=value;
		}

		public static function get turnFlag():int
		{
			return _turnFlag;
		}

		//----------------------------------
		//  tollgates(read-only)
		//----------------------------------
		public static function get tollgates():Array
		{
			return _tollgates;
		}
		//----------------------------------
		//  level(read-write)
		//----------------------------------
		public static function get level():int
		{
			return _level;
		}
		//
		public static function set level(value:int):void
		{
			_level = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  startGame
		//----------------------------------
		public static function startGame():void
		{
			//TODO:
			//agent initialization.
			agent=new GameAgent("CCJGameAgent", FlexGlobals.topLevelApplication as IVisualElement);
			//logic condition who's turn now at first.
//			isComputerTurnNow();
			isHumanTurnNow();
			//flag game is running.
			isRunning=true;
		}

		//----------------------------------
		//  restartGame
		//----------------------------------
		public static function restartGame():void
		{
			//TODO:re-start game
			//clear board,chess pieces
			FlexGlobals.topLevelApplication.cleanUp.addTask(new CleanUpChessPieceTask());
			FlexGlobals.topLevelApplication.cleanUp.addTask(new CleanUpPiecesBitboardTask());
			FlexGlobals.topLevelApplication.cleanUp.start();
			//
//			mx.core.FlexGlobals.topLevelApplication.dumpFootSprint();
			//
			//put down chess pieces again
			//no more create chess gasket again.
			//no more using start up task at Main.mxml.
			var startUpTask:SequenceTask=new SequenceTask();
			startUpTask.addChild(new CreateChessPieceTask());
			startUpTask.addChild(new CreateChessVoTask());
			startUpTask.start();
			//
//			mx.core.FlexGlobals.topLevelApplication.dumpFootSprint();
			//
			startGame();
		}

		//----------------------------------
		//  computerWin
		//----------------------------------
		public static function computerWin():void
		{
			//TODO:
			agent.fsm.changeState(agent.computerWinState);
		}

		//----------------------------------
		//  humanWin
		//----------------------------------
		public static function humanWin():void
		{
			//TODO:
			agent.fsm.changeState(agent.humanWinState);
		}

		//----------------------------------
		//  isComputerTurnNow
		//----------------------------------
		public static function isComputerTurnNow():void
		{
			//delegate fsm transition to computer state.
			agent.fsm.changeState(agent.computerState);
		}

		//----------------------------------
		//  isHumanTurnNow
		//----------------------------------
		public static function isHumanTurnNow():void
		{
			//delegate fsm transition to computer state.
			agent.fsm.changeState(agent.humanState);
		}

		//----------------------------------
		//  getGamePhase
		//----------------------------------
		/**
		 * The game phase is decided by how many pieces both sides have left.
		 * @param gamePosition the current game position information.
		 * @return the current game position's game phase.
		 *
		 */
		public static function getGamePhase(gamePosition:PositionVO):uint
		{
			var gamePhase:uint=PHASE_OPENING;
			if (gamePosition.board.celled <= 14 && gamePosition.board.celled >= 6)
			{
				gamePhase=PHASE_MIDDLE;
			}
			if (gamePosition.board.celled < 6 && gamePosition.board.celled >= 1)
			{
				gamePhase=PHASE_ENDING;
			}
			return gamePhase;
		}
	}
}