package com.lookbackon.ccj.managers
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.ZobristKeysModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.ZobristKeyVO;
	import com.lookbackon.ccj.model.vos.cvo.ChessVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessPiece;
	
	import de.polygonal.math.PM_PRNG;
	
	import mx.logging.ILogger;

	/**
	 * The chess piece manager manage chess piece move's validation.
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessPieceManager
	{
		private static var pmPRNG:PM_PRNG = new PM_PRNG();
		private static const LOG:ILogger = LogUtil.getLogger(ChessPieceManager);
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
		
		public static function makeMove(conductVO:ConductVO):void
		{
			//TODO:implement functions.
			//update ZobristKeys
			/*var zKeyVO:ZobristKeyVO = new ZobristKeyVO();
			var pX:int = conductVO.newPosition.x;
			var pY:int = conductVO.newPosition.y;
			if(conductVO.target.flag==CcjConstants.FLAG_RED)
			{
				ZobristKeysModel.getInstance().redRook.position.sett(pX,pY,
					pmPRNG.nextInt()^ZobristKeysModel.getInstance().redRook.position.gett(pX,pY) );
			}else
			{
				ZobristKeysModel.getInstance().redRook.position.sett(pX,pY,
					pmPRNG.nextInt()^ZobristKeysModel.getInstance().redRook.position.gett(pX,pY) );
			}*/
			
			
		}
	}
}