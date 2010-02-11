package com.lookbackon.ccj.managers
{
	import com.lookbackon.ccj.model.vo.ConductVO;
	import com.lookbackon.ccj.utils.LogUtil;
	
	import mx.logging.ILogger;

	/**
	 * The chess piece manager manage chess piece move's validation.
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessPieceManager
	{
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
			LOG.debug("move validate begin at:{0}",new Date().getMilliseconds());
			//chess piece change state(view).
			conductVO.target.agent.getFSM().changeState(conductVO.target.attackState);
			//TODO:
			//chess piece move logic check.
			LOG.debug("move validate end at:{0}",new Date().getMilliseconds());
			return result;
		}
		
	}
}