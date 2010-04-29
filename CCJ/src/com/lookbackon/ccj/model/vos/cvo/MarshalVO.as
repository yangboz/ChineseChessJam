package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.utils.LogUtil;
	
	import mx.logging.ILogger;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class MarshalVO extends ChessVO
	{
		private static const LOG:ILogger = LogUtil.getLogger(MarshalVO);
		/**
		 * @inheritDoc
		 */		
		public function MarshalVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */	
		override public function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			//TODO: implement function
			//serveral admental(将对面问题)
			//about occupies.
			this.occupies.setBitt(rowIndex,colIndex+1,true);
			this.occupies.setBitt(rowIndex,colIndex-1,true);
			this.occupies.setBitt(rowIndex+1,colIndex,true);
			this.occupies.setBitt(rowIndex-1,colIndex,true);
			//about legal moves.
			if(flag==CcjConstants.FLAG_RED)
			{
				//serveral admental(将对面问题)
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().redPieces));
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().bluePieces));
			}
			//about attacked captures.
			if(flag==CcjConstants.FLAG_RED)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().bluePieces);
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().redPieces);
			}
			//
			LOG.info("occupies:{0}",this.occupies.dump());
			LOG.info("moves:{0}",this.moves.dump());
			LOG.info("captures:{0}",this.captures.dump());
		}
	}
}