package com.lookbackon.ccj.business.fsm.states.game
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.AI.finiteStateMachine.IAgent;
	import com.lookbackon.AI.searching.AlphaBeta;
	import com.lookbackon.AI.searching.AttackFalse;
	import com.lookbackon.AI.searching.ISearching;
	import com.lookbackon.AI.searching.MinMax;
	import com.lookbackon.AI.searching.MiniMax;
	import com.lookbackon.AI.searching.NegaMax;
	import com.lookbackon.AI.searching.PVS;
	import com.lookbackon.AI.searching.Quiescence;
	import com.lookbackon.AI.searching.RandomWalk;
	import com.lookbackon.AI.searching.ShortSighted;
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.business.fsm.GameAgent;
	import com.lookbackon.ccj.business.fsm.StateBase;
	import com.lookbackon.ccj.managers.GameManager;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.utils.LogUtil;
	
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	import mx.logging.ILogger;
	import mx.managers.CursorManager;
	
	import org.flexunit.runner.notification.IRunListener;
	import org.generalrelativity.thread.GreenThread;
	import org.generalrelativity.thread.IRunnable;
	import org.generalrelativity.thread.event.GreenThreadEvent;
	import org.generalrelativity.thread.util.ThreadUtil;

	/**
	 * ComputerState.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 10, 2010 11:11:56 AM
	 */   	 
	public class ComputerState extends StateBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//The agent obtans searching.
		public var searching:ISearching;
		//
		private var processes:Vector.<IRunnable>;
		private var greenThread:GreenThread;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger =  LogUtil.getLogger(ComputerState);
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
		public function ComputerState(agent:IAgent, resource:Object, description:String=null)
		{
			//TODO: implement function
			super(agent, resource, description);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function enter():void
		{
			//TODO: implement function
			//hold turn flag
			GameManager.turnFlag = CcjConstants.FLAG_BLUE;
			//about view
			CursorManager.setBusyCursor();
			//
			GameManager.indicatorReadOut=true;
			//
			//TODO:switch any searching class to test.
			//			gameAI = new RandomWalk(ChessPiecesModel.getInstance().gamePosition);
//			searching = new MinMax(ChessPiecesModel.getInstance().gamePosition);
			searching = new MiniMax(ChessPiecesModel.getInstance().gamePosition,5);
			//			gameAI = new NegaMax(ChessPiecesModel.getInstance().gamePosition,1);
			//			gameAI = new AlphaBeta(ChessPiecesModel.getInstance().gamePosition);
			//			gameAI = new Quiescence(ChessPiecesModel.getInstance().gamePosition);
			//			gameAI = new PVS(ChessPiecesModel.getInstance().gamePosition);
			//			gameAI = new ShortSighted(ChessPiecesModel.getInstance().gamePosition);
//			searching = new AttackFalse(ChessPiecesModel.getInstance().gamePosition);
			//
			//using this flash green thread algorithm to avoid script time limition only 15s.
			processes = new Vector.<IRunnable>();
			processes.push(searching);
			greenThread = new GreenThread(processes, FlexGlobals.topLevelApplication.stage.frameRate);
			//
//			greenThread.addEventListener(GreenThreadEvent.PROCESS_TIMEOUT, function(event:GreenThreadEvent):void
//			{
//				LOG.error(event.toString());
//			});
//			greenThread.addEventListener(GreenThread.CYCLE, function(event:Event):void
//			{
//				LOG.debug(event.toString());
//			});
//			greenThread.addEventListener(GreenThreadEvent.PROCESS_COMPLETE, function(event:GreenThreadEvent):void
//			{
//				LOG.info(event.toString());
//			});
//			greenThread.addEventListener(Event.COMPLETE, function(event:Event):void
//			{
//				LOG.info(event.toString());
//			});
			//
			greenThread.open();
		}
		
		override public function exit():void
		{
			//about view
			CursorManager.removeBusyCursor();
			//
			GameManager.indicatorReadOut=false;
		}
		
		override public function update(time:Number=0):void
		{
			//TODO: implement function
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}