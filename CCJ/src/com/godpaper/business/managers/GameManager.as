package com.godpaper.business.managers
{
	import com.adobe.cairngorm.task.SequenceTask;
	import com.godpaper.business.fsm.GameAgent;
	import com.godpaper.configs.GameConfig;
	import com.godpaper.configs.IndicatorConfig;
	import com.godpaper.configs.PieceConfig;
	import com.godpaper.consts.CcjConstants;
	import com.godpaper.model.ChessPiecesModel;
	import com.godpaper.model.vos.PositionVO;
	import com.godpaper.tasks.CleanUpChessPieceTask;
	import com.godpaper.tasks.CleanUpPiecesBitboardTask;
	import com.godpaper.tasks.CreateChessPieceTask;
	import com.godpaper.tasks.CreateChessVoTask;
	import com.godpaper.utils.LogUtil;
	import com.lookbackon.AI.searching.AttackFalse;
	import com.lookbackon.AI.searching.MiniMax;
	import com.lookbackon.AI.searching.RandomWalk;
	import com.lookbackon.AI.searching.ShortSighted;
	
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
		//
		private static var chessPieceModel:ChessPiecesModel = ChessPiecesModel.getInstance();
		//
		public static var isRunning:Boolean;
		//
		public static var agent:GameAgent;
		//
		public static var level:int=1;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(GameManager);
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
		//  get Game Phase
		//----------------------------------
		/**
		 * The game phase is decided by how many pieces both sides have left.
		 * @param gamePosition the current game position information.
		 * @return the current game position's game phase.
		 */
		public static function get phase():uint
		{
			var gamePhase:uint=PHASE_OPENING;
			if (chessPieceModel.gamePosition.board.celled <= 14 
				&& chessPieceModel.gamePosition.board.celled >= 6
				)
			{
				gamePhase=PHASE_MIDDLE;
			}
			if (chessPieceModel.gamePosition.board.celled < 6 
				&& chessPieceModel.gamePosition.board.celled >= 1
				)
			{
				gamePhase=PHASE_ENDING;
			}
			return gamePhase;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  startGame
		//----------------------------------
		public static function start():void
		{
			//TODO:
			//agent initialization.
			agent=new GameAgent("CCJGameAgent", FlexGlobals.topLevelApplication as IVisualElement);
			//logic condition who's turn now at first.
			if(GameConfig.turnFlag==CcjConstants.FLAG_BLUE)
			{
				isComputerTurnNow();
			}else if(GameConfig.turnFlag==CcjConstants.FLAG_RED)
			{
				isHumanTurnNow();
			}else
			{
				//TODO,another human turn now.
			}
			//flag game is running.
			isRunning=true;
		}

		//----------------------------------
		//  restartGame
		//----------------------------------
		public static function restart():void
		{
			//TODO:re-start game
			//clean up indicators.
			IndicatorConfig.check = false;
			IndicatorConfig.submitScore = false;
			//clear board,chess pieces
			FlexGlobals.topLevelApplication.cleanUpSequenceTask.addTask(new CleanUpChessPieceTask());
			FlexGlobals.topLevelApplication.cleanUpSequenceTask.addTask(new CleanUpPiecesBitboardTask());
			FlexGlobals.topLevelApplication.cleanUpSequenceTask.start();
			//dump the end of game messages.
			FlexGlobals.topLevelApplication.dumpFootSprint();
			//
			//put down chess pieces again
			//no more create chess gasket again.
			//no more using start up task at Main.mxml.
			var startUpTask:SequenceTask=new SequenceTask();
			startUpTask.addChild(new CreateChessPieceTask(PieceConfig.factory));
			startUpTask.addChild(new CreateChessVoTask(PieceConfig.factory));
			startUpTask.start();
			//
			FlexGlobals.topLevelApplication.dumpFootSprint();
			//
			start();
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
	}
}

